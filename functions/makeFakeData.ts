import { db } from './auth'
import trips from './data/all_data.json'

const batch = db.batch()

trips.forEach((e) => {
  const current_trip = db.collection('trips').doc(e.id.toString())

  const areas = e.area.map((v) => {
    return { city: v.substring(0, 3), county: v.substring(3, 6) }
  })

  batch.set(current_trip, {
    title: e.title,
    startDate: e.startDate * 1000 + 3 * 30 * 24 * 60 * 60 * 1000,
    endDate: e.endDate * 1000 + 3 * 30 * 24 * 60 * 60 * 1000,
    area: areas,
    type: e.type,
    level: e.level,
    breif:
      '秀霸線包含池有山、品田山、布秀蘭山、巴紗拉雲山、大霸尖山、小霸尖山、伊澤山和加利山。有別於傳統路線，來趟秀霸連走讚嘆這巍峨神聖的稜線。',
    roadImage: e.roadImage,
    price: e.price,
    memberPrice: e.memberPrice,
    url: e.url,
    limitation: e.limitation,
    images: e.images,
    information: {
      applyStart:
        e.information.applyStart * 1000 + 3 * 30 * 24 * 60 * 60 * 1000,
      applyEnd: e.information.applyEnd * 1000 + 3 * 30 * 24 * 60 * 60 * 1000,
      applyWay: e.information.applyWay,
      gatherPlace: e.information.gatherPlace,
      gatherTime: e.information.gatherTime + 3 * 30 * 24 * 60 * 60 * 1000,
      transportationWay: e.information.transportationWay,
      transportationInfo: e.information.transportationInfo,
      preDepartureMeetingDate:
        e.information.preDepartureMeetingDate + 3 * 30 * 24 * 60 * 60 * 1000,
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
