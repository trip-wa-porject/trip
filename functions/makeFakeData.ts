import { db } from './auth'
import trips from './data/all_data.json'

const batch = db.batch()

const fakeUsers = new Array(15).fill(1)

const type_map: { [key: string]: { type: string; range: number[] } } = {
  郊山步道: { type: '郊山', range: [0, 2] },
  中級山步道: { type: '中級山', range: [2, 4] },
  高山步道: { type: '百岳', range: [4, 7] },
}

const getNearestWeekend = (date: number) => {
  // Copy date so don't mess with provided date
  const d = new Date(date)
  // If weekday, move d to next Saturday else to current weekend Saturday
  if (d.getDay() % 7) {
    d.setDate(d.getDate() + 6 - d.getDay())
  } else {
    d.setDate(d.getDate() - (d.getDay() ? 0 : 1))
  }
  // Return array with Dates for Saturday, Sunday
  return [new Date(d), new Date(d.setDate(d.getDate() + 1))]
}

trips.forEach((e) => {
  const current_trip = db.collection('trips').doc(e.id.toString())

  const areas = e.area.map((v) => {
    return { city: v.substring(0, 3), county: v.substring(3, 6) }
  })

  batch.update(current_trip, {
    title: e.title,
    startDate: e.startDate * 1000 + 3 * 30 * 24 * 60 * 60 * 1000,
    endDate: e.endDate * 1000 + 3 * 30 * 24 * 60 * 60 * 1000,
    area: areas,
    type: type_map[e.type].type ?? '步道',
    level: e.level,
    breif:
      '秀霸線包含池有山、品田山、布秀蘭山、巴紗拉雲山、大霸尖山、小霸尖山、伊澤山和加利山。有別於傳統路線，來趟秀霸連走讚嘆這巍峨神聖的稜線。',
    roadImage: e.roadImage,
    price: e.price,
    memberPrice: e.memberPrice,
    url: e.url,
    limitation: e.limitation,
    images: e.images,
    applicants: [],
    information: {
      applyStart:
        e.information.applyStart * 1000 + 3 * 30 * 24 * 60 * 60 * 1000,
      applyEnd: e.information.applyEnd * 1000 + 3 * 30 * 24 * 60 * 60 * 1000,
      applyWay: e.information.applyWay,
      gatherPlace: e.information.gatherPlace,
      gatherTime:
        e.information.gatherTime * 1000 + 3 * 30 * 24 * 60 * 60 * 1000,
      transportationWay: e.information.transportationWay,
      transportationInfo: e.information.transportationInfo,
      preDepartureMeetingDate:
        e.information.preDepartureMeetingDate * 1000 +
        3 * 30 * 24 * 60 * 60 * 1000,
      preDepartureMeetingPlace: e.information.preDepartureMeetingPlace,
      memo: e.information.memo,
      leader: e.information.leader,
      guides: e.information.guides,
      note: e.information.note,
      arriveSite: e.information.arriveSite,
    },
    status: e.status,
  })
})

fakeUsers.forEach((e, index) => {
  const current_user = db.collection('users').doc(`fake_user_${index}`)
  const now = new Date()
  batch.set(current_user, {
    idno: `F12345554${index}`,
    email: `test_email_${index}@test.com`,
    name: `test_name_${index}`,
    mobile: `092312451${index}`,
    emergentContactor: `test_emergentContactor_${index}`,
    emergentContactTel: `094421251${index}`,
    contactorRelationship: `test_relation_${index}`,
    sexual: index % 2,
    address: `test_address_${index}`,
    birth: `2023/04/${index}`,
    member: index % 2,
    createDate: now.getTime(),
    updateDate: now.getTime(),
    registerTrips: [],
    agreements: { version_1: [1, 1, 1, 1] },
  })
})

batch
  .commit()
  .then(() => {
    console.log('batch update success')
  })
  .catch((e) => {
    console.log(e)
    console.log('batch update failed')
  })

// 日期：新增週末行程，從5/20開始，可報名行程主要為7月週末（7/1.2…)

// 路線類型：郊山、中級山、百岳

// 天數：改成複選，新增1天內、2天行程，部分3天、3天以上的天數資料

// 金額：1.增加0元資料（1日內行程）
// 2.一般會員的價格 > VIP 會員，例如一般會員是4500，VIP會員就是4200，便宜200~500元

// 等級：三種隨機

// 行程列表卡片：日期較近的狀態更正為已額滿（例：5月行程為已額滿）

// 討論

// 天數改成複選、篩選器的「天數」需要改成複選
