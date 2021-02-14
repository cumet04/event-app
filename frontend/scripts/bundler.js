const {resolve} = require('path');
const fs = require('fs');
const esbuild = require('esbuild');

const env = process.argv[2] === 'dev' ? 'dev' : 'production';
const srcPath = './src';
const distPath = require('../tsconfig.json').compilerOptions.outDir;
const publicPath = './static';
const webPort = 5000;
const apiPort = 3000;

const buildOpts = {
  entryPoints: [resolve(srcPath, 'index.tsx')],
  outfile: resolve(distPath, 'bundle.js'),
  bundle: true,
  platform: 'browser',
  minify: env === 'production',
  sourcemap: env === 'dev' ? 'inline' : false,
  incremental: env === 'dev',
  define: {
    'process.env.NODE_ENV': `"${env}"`,
  },
  loader: {
    '.png': 'file',
  },
};

const buildOptsCss = {
  file: resolve(srcPath, 'index.scss'),
  outputStyle: env === 'dev' ? 'expanded' : 'compressed',
  sourceMap: env === 'dev',
  sourceMapEmbed: true,
  outFile: resolve(distPath, 'index.css'),
};

async function entry() {
  const builder = await esbuild.build(buildOpts);
  buildCss();
  fs.readdirSync(resolve(publicPath)).forEach(path => {
    fs.copyFileSync(resolve(publicPath, path), resolve(distPath, path));
  });
  if (env !== 'dev') return;

  const chokidar = require('chokidar');

  chokidar
    .watch(resolve(srcPath), {ignored: /index\.scss/})
    .on('change', async () => {
      try {
        await builder.rebuild();
      } catch (e) {
        process.stderr.write(`[ERROR]: ${e}\n`);
      }
    });
  chokidar.watch(resolve(srcPath, 'index.scss')).on('change', buildCss);

  dev({
    targetDir: resolve(distPath),
    webPort,
    apiPort,
  });
}

function buildCss() {
  const result = require('sass').renderSync(buildOptsCss);
  fs.writeFileSync(buildOptsCss.outFile, result.css);
}

function dev({targetDir, webPort, apiPort}) {
  const express = require('express');
  const proxy = require('http-proxy-middleware');

  const app = express();
  app.use(require('connect-livereload')());
  app.use(express.static(targetDir));
  app.use(
    '/api',
    proxy.createProxyMiddleware({
      target: `http://localhost:${apiPort}`,
    })
  );
  app.get('*', (_, res) => res.sendFile(resolve(targetDir, 'index.html')));
  app.listen(webPort);

  require('livereload').createServer().watch(targetDir);
}

entry();
