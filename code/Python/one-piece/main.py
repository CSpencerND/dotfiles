import requests
from bs4 import BeautifulSoup

res = requests.get('https://www.reddit.com/r/OnePiece/search?q=spoilers&restrict_sr=1')
soup = BeautifulSoup(res.text, 'html.parser')
post = soup.select("h3")

print(post)
