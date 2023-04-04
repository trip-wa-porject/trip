import requests
import re
from faker import Faker

# res = requests.get('http://www.thma.org.tw/event_view.php?eid=2025')

# with open('thma.html', 'w') as f:
#     f.write(res.text)

list_page = "http://www.thma.org.tw/event.php?page={current_page}"


# title = re.search(r'(.*?)\(', a).group().replace('(', '')
fake = Faker("zh_TW")

for i in range(10):
    print(fake.name_male())
    print(fake.phone_number())
