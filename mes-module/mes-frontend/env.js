// env.js

export const API_BASE_URL = 'http://localhost:3001/';

export const API_ENDPOINTS = {
  // Authentication
  LOGIN: `${API_BASE_URL}auth/login`,
  REGISTER: `${API_BASE_URL}auth/register`,
  LOGOUT: `${API_BASE_URL}auth/logout`,

  // Users
  GET_USERS: `${API_BASE_URL}users`,
  GET_USER: `${API_BASE_URL}users/:id`,
  UPDATE_USER: `${API_BASE_URL}users/:id`,
  DELETE_USER: `${API_BASE_URL}users/:id`,

  // Products
  GET_PRODUCTS: `${API_BASE_URL}products`,
  GET_PRODUCT: `${API_BASE_URL}products/:id`,
  CREATE_PRODUCT: `${API_BASE_URL}products`,
  UPDATE_PRODUCT: `${API_BASE_URL}products/:id`,
  DELETE_PRODUCT: `${API_BASE_URL}products/:id`,
};