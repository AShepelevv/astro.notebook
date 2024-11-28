FROM nixos/nix:latest

WORKDIR /build
COPY . .

RUN nix-build

FROM scratch
COPY --from=0 /buildresult/astro-notebook.pdf /
