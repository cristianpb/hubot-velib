# hubot-velib

[![npm version](https://badge.fury.io/js/hubot-velib.svg)](https://badge.fury.io/js/hubot-velib) [![Build Status](https://travis-ci.org/cristianpb/hubot-velib.svg?branch=master)](https://travis-ci.org/cristianpb/hubot-velib)

A hubot script to search for velibs bikes in Paris

See [`src/velib.coffee`](src/velib.coffee) for full documentation.

## Installation

In hubot project repo, run:

`npm install hubot-velib --save`

Then add **hubot-velib** to your `external-scripts.json`:

```json
[
  "hubot-velib"
]
```

## Sample Interaction

```
user1>> velibs in Monparnasse
hubot>> There are 2 stations:
Pontoise - La Tournelle: 15 over 24
Sommerard - Saint-Jacques: 12 over 34
```

## NPM Module

https://www.npmjs.com/package/hubot-velib
