all: /swapfile /etc/localtime /etc/fonts/conf.d/70-noto-cjk.conf
	free

/swapfile:
	sudo dd if=/dev/zero of=$@ bs=1024 count=8138702
	sudo chmod 600 $@
	sudo mkswap $@
	sudo swapon $@

/etc/localtime: /usr/share/zoneinfo/Asia/Tokyo
	sudo ln -snf $< $@

/etc/fonts/conf.d/%: /etc/fonts/conf.avail/%
	sudo ln -snf $< $@

setup: $(HOME)/.npmrc $(HOME)/.zshlocal /usr/local/bin/rebar3
	sudo pacman -R \
		ibus \
		|| true;
	sudo pacman -Syu --noconfirm --needed \
		bind-tools \
		docker \
		docker-compose \
		erlang \
		firefox \
		fcitx-im \
		fcitx-configtool \
		fcitx-mozc \
		git \
		go \
		htop \
		jq \
		neovim \
		noto-fonts \
		noto-fonts-cjk \
		noto-fonts-emoji \
		noto-fonts-extra \
		nodejs \
		npm \
		perl \
		python \
		python-pynvim \
		ripgrep \
		ruby \
		ttf-fira-mono \
		ttf-fira-sans \
		ttf-fira-code \
		tmux \
		weechat \
		zsh \
		;
	sudo usermod -aG docker yowcow \
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

/usr/local/bin/rebar3: VERSION := 3.13.1
/usr/local/bin/rebar3:
	sudo curl -L https://github.com/erlang/rebar3/releases/download/$(VERSION)/rebar3 -o $@ && \
		sudo chmod 755 $@

.PHONY: all setup
