import requests
import random
import csv
from bs4 import BeautifulSoup
import datetime
from pprint import pprint
import time

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

    except:
        pass

def parse_html(id, html):
    soup = BeautifulSoup(html, features="html.parser")

    if soup.select_one('title').text == '找不到網頁 - 健行筆記':
        return False

    title = soup.select_one(".space-y-2\\.5 h1").text
    imageUrl = soup.select_one(".main-left img").attrs["src"]

    start_date = today + datetime.timedelta(random.randint(3, 24))
    end_date = start_date + datetime.timedelta(random.randint(2, 7))

    route_info = parse_seperate_info(
        soup, "#category_route .leading-relaxed div.flex-1"
    )

    road_image = soup.select_one(
        "#category_map > dl > div:nth-child(5) > dd > img"
    ).attrs["data-src"]
    price = random.randint(500, 3500)

    return [
        id,
        title,
        imageUrl,
        start_date.strftime("%Y-%m-%d"),
        end_date.strftime("%Y-%m-%d"),
        route_info["所在縣市"],
        route_info["步道類型"],
        route_info["海拔高度"],
        route_info["難易度"],
        road_image,
        random.randint(3, 25),
        price,
        price + 500,
        hiking_url.format(current_id=id),
    ]

def parse_seperate_info(soup, selector):
    route_info = soup.select(selector)
    route_info_dict = {}

    for i in route_info:
        if i.select_one("dt") and i.select_one("dd"):
            route_info_dict[i.select_one("dt").text.strip()] = i.select_one(
                "dd"
            ).text.strip()

    return route_info_dict

with open("final_output.csv", "w") as f:
    writer = csv.writer(f)
    writer.writerow(columns)

    for index in range(6, total_trip):
        print(f'start id = {index} trip')
        info = get_info_from_hiking(index)
        if info:
            print(f'success get trip info {index}')
            writer.writerow(info)
        else:
            print(f'failed get trip info {index}')

        time.sleep(random.randint(1,6))

