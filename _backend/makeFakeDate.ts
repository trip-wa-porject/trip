import { db } from './auth'
import trips from './data/test_trips.json'

import type { Trip } from './@types'

const batch = db.batch()

trips.forEach((e: Trip) => {
  const current_trip = db.collection('dev_trip').doc(e.id.toString())

  const areas = e.area.map((v) => {
    return { city: v.substring(0, 3), county: v.substring(3, 6) }
  })

  batch.set(current_trip, {
    title: e.title,
    startDate: new Date(e.startDate * 1000).toJSON().substring(0, 10),
    endDate: new Date(e.endDate * 1000).toJSON().substring(0, 10),
    area: areas,
    type: e.type,
    level: e.level,
    breif:
      '秀霸線包含池有山、品田山、布秀蘭山、巴紗拉雲山、大霸尖山、小霸尖山、伊澤山和加利山。有別於傳統路線，來趟秀霸連走讚嘆這巍峨神聖的稜線。',
    roadImage: e.roadImage,
    price: e.price,
    memberPrice: e.memberPrice,
    url: e.url,
    applicants: e.applicants,
    limitation: e.limitation,
    images: e.images,
    information: {
      applyStart: new Date(e.information.applyStart * 1000)
        .toJSON()
        .substring(0, 10),
      applyEnd: new Date(e.information.applyEnd * 1000)
        .toJSON()
        .substring(0, 10),
      applyWay: e.information.applyWay,
      gatherPlace: e.information.gatherPlace,
      gatherTime: new Date(e.information.gatherTime * 1000)
        .toJSON()
        .substring(0, 16),
      transportationWay: e.information.transportationWay,
      transportationInfo: e.information.transportationInfo,
      preDepartureMeetingDate: new Date(
        e.information.preDepartureMeetingDate * 1000
      )
        .toJSON()
        .substring(0, 16),
      preDepartureMeetingPlace: e.information.preDepartureMeetingPlace,
      memo: e.information.memo,
      leader: e.information.leader,
      guides: e.information.guides,
      note: e.information.note,
      arriveSite: e.information.arriveSite
    },
    status: e.status
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
