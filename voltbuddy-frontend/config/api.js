// Central API configuration
export const API_CONFIG = {
  BASE_URL:
    process.env.NEXT_PUBLIC_API_URL ||
    'http://voltbuddy-backend-alb-872090665.us-east-1.elb.amazonaws.com/api',

  DEV_URL: 'http://localhost:5001/api',
};

// Get the appropriate API URL
export const getApiUrl = () => {
  if (process.env.NODE_ENV === 'development') {
    return API_CONFIG.DEV_URL;
  }

  return API_CONFIG.BASE_URL;
};

// Export for easy use
export const API_BASE_URL = getApiUrl();