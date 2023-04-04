import requests
import random
from bs4 import BeautifulSoup
import datetime
from pprint import pprint
import time
import json

hiking_url = "https://hiking.biji.co/index.php?q=trail&act=detail&id={current_id}"
total_trip = 1750

columns = [
    "行程編號",
    "路線名稱",
    "路線圖片",
    "開始日期",
    "結束日期",
    "路線所在縣市",
    "步道類型",
    "海拔高度",
    "難易度",
    "路線圖",
    "名額限制",
    "收費金額-會員",
    "收費金額-非會員",
    "參考 url",
]

today = datetime.datetime.now()


def get_info_from_hiking(id):
    try:
        url = hiking_url.format(current_id=id)
        res = requests.get(url)
        if res.status_code != 200:
            return False

        return parse_html(id, res.content)

    except Exception as e:
        print(e)

def parse_html(id, html):
    soup = BeautifulSoup(html, features="html.parser")

    title = soup.select_one("title").text

    title = soup.select_one(".space-y-2\\.5 h1").text
    imageUrl = soup.select_one(".main-left img").attrs["src"]

    start_date = today + datetime.timedelta(random.randint(3, 24))
    end_date = start_date + datetime.timedelta(random.randint(2, 7))

    apply_start = today - datetime.timedelta(random.randint(30, 45))
    apply_end = apply_start + datetime.timedelta(random.randint(10, 15))

    route_info = parse_seperate_info(
        soup, "#category_route .leading-relaxed div.flex-1"
    )

    road_image = (
        soup.select_one("#category_map > dl > div:nth-child(5) > dd > img") or ""
    )
    if road_image:
        road_image = road_image.attrs["data-src"]

    price = random.randint(500, 3500)
  
    limit =random.randint(10, 30)

    level = ['A', 'B', 'C']

    return {
        "id": id,
        "title": title,
        "startDate": int(start_date.timestamp()),
        "endDate": int(end_date.timestamp()),
        "area": route_info["所在縣市"].split(','),
        "type": route_info["步道類型"],
        "level": random.choice(level),
        "roadImage": road_image,
        "price": price,
        "memberPrice": price + 500,
        "url": hiking_url.format(current_id=id),
        "applicants": limit - random.randint(0, 9),
        "limitation": limit,
        "images": [imageUrl],
        "information": {
            "applyStart": int(apply_start.timestamp()),
            "applyEnd": int(apply_end.timestamp()),
            "applyWay": "向活動收費組報名,亦開放線上報名",
            "gatherPlace": "新埔捷運站２號出口",
            "gatherTime": int((start_date - datetime.timedelta(1)).replace(hour=14, minute=0, second=0).timestamp()),
            "transportationWay": "專車",
            "transportationInfo": "前一天下午二點集合",
            "preDepartureMeetingDate": int((start_date - datetime.timedelta(1)).replace(hour=14, minute=0, second=0).timestamp()),
            "preDepartureMeetingPlace": "220 新北市 板橋區 陽明街76號5樓",
            "memo": "食宿另計",
            "leader": "呂萬龍 0918122870",
            "guides": ["林麗英", "吳泰學", "陳尚融", "林盈吉"],
            "note": "",
            "arriveSite": '在山腳下'
        },
        "status": 0,
    }

def parse_seperate_info(soup, selector):
    route_info = soup.select(selector)
    route_info_dict = {}

    for i in route_info:
        if i.select_one("dt") and i.select_one("dd"):
            route_info_dict[i.select_one("dt").text.strip()] = i.select_one(
                "dd"
            ).text.strip()
    return route_info_dict

with open("final_output.json", "w") as f:
    trip= []

    for index in range(100, 500):
        info = get_info_from_hiking(index)
        if info:
            trip.append(info)
        else:
            print(f"failed get trip info {index}")

        time.sleep(random.randint(1, 6))

    f.write(json.dumps(trip, ensure_ascii=False))