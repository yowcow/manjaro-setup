TIMEZONE := Asia/Tokyo

all: /etc/localtime $(HOME)/.npmrc

/etc/localtime: /usr/share/zoneinfo/$(TIMEZONE)
	sudo ln -snf $< $@

$(HOME)/.npmrc: $(HOME)/.npm
	echo "prefix = $<" > $@

$(HOME)/.npm:
	mkdir -p $@

install:
	sudo pacman -Syu --noconfirm --needed \
		git \
		neovim \
		noto-fonts \
		noto-fonts-cjk \
		noto-fonts-emoji \
		noto-fonts-extra \
		nodejs \
		npm \
		python \
		python-pynvim \
		ripgrep \
		ruby \
		ttf-fira-mono \
		ttf-fira-sans \
		ttf-fira-code \
		tmux \
		zsh \
		;
	npm install -g neovim \
		;
	gem i neovim \
		;
