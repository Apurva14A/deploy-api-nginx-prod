FROM nginx:alpine

ENV NGINX_ENV=development

# Create a non-root user and group, update packages, and remove default config
RUN rm /etc/nginx/conf.d/default.conf

COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 8070

HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
  CMD wget --spider -q http://localho:8070/api/v1 || exit 1

CMD [ "nginx", "-g", "daemon off;" ]
