FROM gentoo/portage as gentoo
FROM ghcr.io/bencord0/portage-overlay:master as bencord0
FROM gentoo/stage3 as stage3

COPY repos.conf /etc/portage/repos.conf
RUN ln -sf \
    /var/db/repos/bencord0/profiles/default/linux/amd64/docker \
    /etc/portage/make.profile

RUN \
    --mount=type=bind,target=/var/db/repos/gentoo,source=/var/db/repos/gentoo,from=gentoo \
    --mount=type=bind,target=/var/db/repos/bencord0,source=/var/db/repos/bencord0,from=bencord0 \
    --mount=type=cache,target=/var/cache/binpkgs \
    --mount=type=cache,target=/var/cache/distfiles \
    emerge --quiet \
        app-editors/vim \
        www-servers/nginx
