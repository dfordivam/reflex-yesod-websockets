# reflex-yesod-websockets

Do communication between Reflex frontend and Yesod backend using websocket
protocol.

This will compile and run the yesod server on port 3000
```
cd backend; stack build; stack exec reflex-yesod-websockets-backend
```

For compiling front-end use the script from [reflex-platform][reflex-link]
```
/path/to/reflex-platform/work-on ghcjs ./frontend
cd frontend; cabal configure --ghcjs && cabal build
```

Then open the generated [index.html][index-link] in browser.

Note that if you open [localhost:3000](http://localhost:3000) directly in browser then it will use the page from yesod instead, which essentially does the same work as reflex frontend.

[reflex-link]: https://github.com/reflex-frp/reflex-platform
[index-link]: frontend/dist/build/reflex-yesod-websockets-frontend/reflex-yesod-websockets-frontend.jsexe/index.html
