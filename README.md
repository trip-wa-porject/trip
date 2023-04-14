查詢單一會員所有行程：

curl -k -H "Content-Type:application/json" http://127.0.0.1:5001/trip-b6ddf/us-central1/getUserAllTrips -d '{"userId":"123456"}'

{"result":[{"updateDate":1680792322313,"price":5200,"paymentExpireDate":"2023-04-10","tripId":"110001","id":"m2ogLuNPJd12t8BgzV0b","userId":"123456","paymentInfo":{"accountNo":"54321"},"createDate":1680792322313,"status":0},{"updateDate":1680795497488,"price":5200,"paymentExpireDate":"2023-04-10","tripId":"110002","id":"EhV4uD13icpA2B1IVOXy","userId":"123456","paymentInfo":{"accountNo":"54321"},"status":0,"createDate":1680795497488},{"updateDate":1680875980709,"price":5200,"paymentExpireDate":"2023-04-10","tripId":"110003","id":"eS11Bc1BvwCTjbIJ6Lsd","userId":"123456","paymentInfo":{"accountNo":"54321"},"status":0,"createDate":1680875980709}]}

查詢單筆行程：

curl -k -H "Content-Type:application/json" http://127.0.0.1:5001/mountain-climb-b03b9/us-central1/getOneTrip -d '{"id":"m2ogLuNPJd12t8BgzV0b"}'

{"result":{"updateDate":1680792322313,"price":5200,"paymentExpireDate":"2023-04-10","tripId":"110001","id":"m2ogLuNPJd12t8BgzV0b","userId":"123456","paymentInfo":{"accountNo":"54321"},"createDate":1680792322313,"status":0}}

新增會員：

curl -k -H "Content-Type:application/json" http://127.0.0.1:5001/mountain-climb-b03b9/us-central1/addUser -d '{"id":"123456","email":"amew@gmail.com","name":"陳阿喵","mobile":"0987654321","idno":"A123456789","emergentContactor":"陳旺旺","emergentContactTel":"0987654321","sexual":0,"address":"台北市中山區中山北路","birth":"2006-07-23","contactorRelationship":"pet","member":0,"agreements":{"version":"1.0"}}'

{"result":"123456"}

取得會員：

curl -k -H "Content-Type:application/json" http://127.0.0.1:5001/mountain-climb-b03b9/us-central1/getUser -d '{"id":"123456"}'

更新會員資料：

curl -k -H "Content-Type:application/json" http://127.0.0.1:5001/mountain-climb-b03b9/us-central1/updateUser -d '{"id":"m2ogLuNPJd12t8BgzV0b","status":"done"}'

{"result":{"updateDate":1681395966621,"address":"台北市中山區中山北路","mobile":"0987654321","birth":"2006-07-23","agreements":{"version":"1.0"},"membership":0,"idno":"A123456789","contactorRelationship":"pet","emergentContactor":"陳旺旺","name":"陳阿喵","id":"123456","emergentContactTel":"0987654321","email":"amew@gmail.com","sexual":0,"createDate":1681395966621}}

新增報名：

curl -k -H "Content-Type:application/json" http://127.0.0.1:5001/mountain-climb-b03b9/us-central1/addRegistration -d '{"tripId":"110001","price":5200,"paymentExpireDate":"2023-04-10","paymentInfo":{},"emergentContactor":"陳旺旺","emergentContactTel":"0987654321","sexual":0,"address":"台北市中山區中山北路","birth":"2006-07-23","contactorRelationship":"pet","member":0}'

{"result":"QjBMvHMUHqfArUtdgeFp"}

更新報名資訊：

curl -k -H "Content-Type:application/json" http://127.0.0.1:5001/mountain-climb-b03b9/us-central1/updateRegistration -d '{"id":"m2ogLuNPJd12t8BgzV0b-","status":0}'

{"result":{"\_writeTime":{"\_seconds":1681316463,"\_nanoseconds":854580000}}}
