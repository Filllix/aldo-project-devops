FROM nginx:alpine

COPY index.html /usr/share/nginx/html/index.html

HEALTHCHECK --interval=10s --timeout=3s --retries=3 \
  CMD wget -q --spider http://127.0.0.1/ || exit 1
