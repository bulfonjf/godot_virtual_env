FROM alpine:latest

# Environment Variables
ENV GODOT_VERSION "3.2.3"
ENV GODOT_EXPORT_PRESET="Linux/X11"

# Updates and installs to the server
RUN apk update

# Add useful packages
RUN apk add --no-cache \
		wget \
		curl \
		gcc \
		libc-dev \
		docker \
		openssh \
		zsh \
		git \
		vim \
		fzf \
		ripgrep

# Allow this to run Godot
RUN wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.31-r0/glibc-2.31-r0.apk
RUN apk add --allow-untrusted glibc-2.31-r0.apk

# Download Godot and export template, version is set from variables
RUN wget https://downloads.tuxfamily.org/godotengine/${GODOT_VERSION}/Godot_v${GODOT_VERSION}-stable_linux_headless.64.zip \
    && wget https://downloads.tuxfamily.org/godotengine/${GODOT_VERSION}/Godot_v${GODOT_VERSION}-stable_export_templates.tpz \
    && mkdir ~/.cache \
    && mkdir -p ~/.config/godot \
    && mkdir -p ~/.local/share/godot/templates/${GODOT_VERSION}.stable \
    && unzip Godot_v${GODOT_VERSION}-stable_linux_headless.64.zip \
    && mv Godot_v${GODOT_VERSION}-stable_linux_headless.64 /usr/local/bin/godot \
    && unzip Godot_v${GODOT_VERSION}-stable_export_templates.tpz \
    && mv templates/* ~/.local/share/godot/templates/${GODOT_VERSION}.stable \
    && rm -f Godot_v${GODOT_VERSION}-stable_export_templates.tpz Godot_v${GODOT_VERSION}-stable_linux_headless.64.zip

WORKDIR /root

RUN curl -fLo .vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

COPY .ssh .ssh/
COPY ./myproject myproject/
COPY .vimrc .

# Install vim plugins
RUN ["/bin/zsh", "-c", "vim -E -s -u '/root/.vimrc' +PlugInstall +qall"]

WORKDIR myproject/
