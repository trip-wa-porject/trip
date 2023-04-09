import { db } from './auth'
import trips from './data/test_trips.json'

const batch = db.batch()

trips.forEach((e) => {
  const current_trip = db.collection('dev_trip').doc(e.id.toString())

  const areas = e.area.map((v) => {
    return { city: v.substring(0, 3), county: v.substring(3, 6) }
  })

  batch.set(current_trip, {
    title: e.title,
    startDate: e.startDate,
    endDate: e.endDate,
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
      applyStart: e.information.applyStart,
      applyEnd: e.information.applyEnd,
      applyWay: e.information.applyWay,
      gatherPlace: e.information.gatherPlace,
      gatherTime: e.information.gatherTime,
      transportationWay: e.information.transportationWay,
      transportationInfo: e.information.transportationInfo,
      preDepartureMeetingDate: e.information.preDepartureMeetingDate,
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
