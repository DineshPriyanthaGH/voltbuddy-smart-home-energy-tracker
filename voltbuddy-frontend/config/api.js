// Central API configuration
export const API_CONFIG = {
  BASE_URL:
    process.env.NODE_ENV === 'development'
      ? 'http://localhost:5001/api'
      : '/api',

  DEV_URL: 'http://localhost:5001/api',
};

// Get the appropriate API URL
export const getApiUrl = () => API_CONFIG.BASE_URL;

// Export for easy use
export const API_BASE_URL = getApiUrl();