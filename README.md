# trnsltr

Here's an idea that might solve translating Rails apps once and for all:

A simple tool that connects to your GitHub repo, fetches all `.yml` files from `config/locales`, puts them into a table for editing, and commits them back to master when you're done.

Try it here: https://trnsltr.herokuapp.com

## Todo

- [ ] Make a "real" UI with Svelte
- [ ] Make branch configurable
- [ ] Search for keys
- [ ] Collapse/expand keys 
- [ ] Only submit the keys that have changed

## Disclaimer

EARLY PROTOTYPE. USE AT YOUR OWN RISK.

The UI is crappy and hard to use if you have a large number of translation keys.
