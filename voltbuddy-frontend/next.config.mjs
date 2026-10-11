/** @type {import('next').NextConfig} */

const nextConfig = {
  async rewrites() {
    return [
      {
        source: '/api/:path*',
        destination:
          'http://voltbuddy-backend-alb-872090665.us-east-1.elb.amazonaws.com/api/:path*',
      },
    ];
  },
};
export default nextConfig;