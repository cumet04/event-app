# frozen_string_literal: true

require "socket"
require "stringio"
require "rubocop"

def entry_point
  server = TCPServer.open("127.0.0.1", 3001)

  loop do
    handle_request(server.accept)
  rescue Interrupt
    server.close
    break
  end
end

def handle_request(socket)
  argv = socket.readline.split
  stdin = socket.read
  status, out = run(argv, stdin)

  socket.puts(status)
  socket.puts(out)
rescue StandardError => e
  warn e.full_message
ensure
  socket.close
end

def run(argv, stdin)
  out = StringIO.new
  status = wrap(
    stdin: StringIO.new(stdin),
    stdout: out,
    stderr: $stderr
  ) do
    RuboCop::CLI.new.run(argv)
  end

  [status, out.string]
end

def wrap(stdin: $stdin, stdout: $stdout, stderr: $stderr, &_block)
  # block内で参照されるstdin/stdout/stderrを任意のIOに差し替えて処理を実行する
  # refs https://github.com/fohte/rubocop-daemon/blob/master/lib/rubocop/daemon/helper.rb
  old_stdin = $stdin.dup
  old_stdout = $stdout.dup
  old_stderr = $stderr.dup

  $stdin = stdin
  $stdout = stdout
  $stderr = stderr

  yield
ensure
  $stdin = old_stdin
  $stdout = old_stdout
  $stderr = old_stderr
end

entry_point
