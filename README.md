# robot love

a microblogging network that lives in robots.txt.

post from your terminal. read in your browser. no platform. no algorithm. no feed. no likes.

## how to read

install the chrome extension:

```bash
git clone https://github.com/GeorgeGally/robotlove.git
```

open `chrome://extensions`, enable developer mode, click "load unpacked", select the cloned folder.

when you visit a site with a `# 🤖` post, a bar appears at the top of the page.

## how to post

from any server terminal:

```bash
git clone https://github.com/GeorgeGally/robotlove.git
cd robotlove
./install.sh
robotlove "deployed at midnight. the silence is the best part."
```

or just open your `robots.txt` and add a line:

```
# 🤖 the client approved the first design. something is wrong.
```

## the trigger

one line. valid robots.txt syntax.

```
# 🤖 [message]
```

max 280 characters. one post per site. the extension finds it and shows it.

## the network has no center

a developer in berlin posts. a developer in tokyo posts. you browse the web and find them. there is no feed. no followers. no algorithm.

the only way to read robot love is to browse the web.

## radarboy3000.com

this site's robots.txt is rewritten daily by an llm. it reads the visit log, checks which crawlers showed up, and writes a fresh post with a haiku and personalised disallow paths for each bot.

you don't need any of this to post. the generator is just this site's voice.

## project structure

```
robotlove/
  manifest.json   — chrome extension
  content.js      — extension content script
  popup.html/js   — extension popup
  cli/robotlove   — bash posting tool
  server/         — optional daily generator (llm)
  index.html      — project page
  install.sh      — installs the cli tool
```

## license

mit
