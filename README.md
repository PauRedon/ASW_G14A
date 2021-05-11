ASW_G14A
```
Pau Redon
Alejandro Santandreu
Joel Crespo
Antonio Barrantes
Jaume Armengol
```
#To execute:
```
echo "gem: --no-document" >> ~/.gemrc
gem install rails -v 6.1.3
source <(curl -sL https://cdn.learnenough.com/yarn_install)
gem install bundler -v 2.2.16
bundle config set --local without 'production'
bundle install
yarn install --check-files
rails server
```

App a heroku: https://hacker-news-g14a.herokuapp.com/

