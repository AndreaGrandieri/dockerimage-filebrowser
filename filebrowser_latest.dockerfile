# Andrea Grandieri andreagrandieri.github.io grn@giusp.com

FROM alpine:3.21
LABEL author="Andrea Grandieri andreagrandieri.github.io grn@giusp.com"
LABEL tag="latest"
LABEL arch="adaptive"
LABEL base="alpine:3.21"

RUN apk add --no-cache curl bash
RUN apk add --no-cache python3 tar nano

# This always gets the latest version of filebrowser
RUN curl -fsSL https://raw.githubusercontent.com/filebrowser/get/master/get.sh | bash

WORKDIR /data/

ENV FB_INIT_USER="admin"
ENV FB_INIT_PASS="admin"

EXPOSE 80

CMD ["sh", "-c", "if [ ! -f /data/filebrowser_settings/filebrowser.db ]; \
    then \
        filebrowser config init -r /data -p 80 --address 0.0.0.0 -d /data/filebrowser_settings/filebrowser.db > /dev/null 2>&1 && \
        filebrowser users add $FB_INIT_USER $FB_INIT_PASS --perm.admin -d /data/filebrowser_settings/filebrowser.db > /dev/null 2>&1; \
    else \
        filebrowser config set -r /data -p 80 --address 0.0.0.0 -d /data/filebrowser_settings/filebrowser.db > /dev/null 2>&1 && \
        printf '%s' 'Database for settings already exists: no user will be created or ' \
        'modified due to filebrowser way of handling configurations. If you lost the ' \
        'login credentials you will have to delete filebrowser.db and redeploy ' \
        'the container.\n'; \
    fi && \
    filebrowser -d /data/filebrowser_settings/filebrowser.db" \
]
