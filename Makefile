all: /etc/localtime /etc/fonts/conf.d/70-noto-cjk.conf

/etc/localtime: /usr/share/zoneinfo/Asia/Tokyo
	sudo ln -snf $< $@

/etc/fonts/conf.d/%: /etc/fonts/conf.avail/%
	sudo ln -snf $< $@

setup: $(HOME)/.npmrc $(HOME)/.zshlocal
	sudo pacman -R \
		ibus \
		|| true;
	sudo pacman -Syu --noconfirm --needed \
		bind-tools \
		fcitx-im \
		fcitx-configtool \
		fcitx-mozc \
		git \
		htop \
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

$(HOME)/.npmrc: $(HOME)/.npm
	echo "prefix = $<" > $@

$(HOME)/.npm:
	mkdir -p $@

$(HOME)/.zshlocal:
	echo 'export PATH=~/.gem/ruby/2.7.0/bin:$$PATH' > $@

.PHONY: all setup
