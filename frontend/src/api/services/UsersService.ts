/* istanbul ignore file */
/* tslint:disable */
/* eslint-disable */
import type { User } from '../models/User';
import { request as __request } from '../core/request';

export class UsersService {

    /**
     * register a user
     * @returns any Created
     * @throws ApiError
     */
    public static async registerUser({
        requestBody,
    }: {
        requestBody?: {
            user: {
                name: string,
                email: string,
                password: string,
            },
        },
    }): Promise<{
        user?: User,
    }> {
        const result = await __request({
            method: 'PUT',
            path: `/users`,
            body: requestBody,
        });
        return result.body;
    }

    /**
     * Your GET endpoint
     * get current login user info
     * @returns any OK
     * @throws ApiError
     */
    public static async getCurrentUser(): Promise<{
        user: User,
    }> {
        const result = await __request({
            method: 'GET',
            path: `/users/current`,
        });
        return result.body;
    }

    /**
     * login
     * @returns any Accepted
     * @throws ApiError
     */
    public static async login({
        requestBody,
    }: {
        requestBody?: {
            user: {
                email: string,
                password: string,
            },
        },
    }): Promise<any> {
        const result = await __request({
            method: 'POST',
            path: `/users/session`,
            body: requestBody,
        });
        return result.body;
    }

    /**
     * logout
     * @returns any Accepted
     * @throws ApiError
     */
    public static async logout(): Promise<any> {
        const result = await __request({
            method: 'DELETE',
            path: `/users/session`,
        });
        return result.body;
    }

}