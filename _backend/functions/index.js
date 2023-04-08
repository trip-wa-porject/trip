"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const auth_1 = require("./auth");
// console.log(db)
console.log(auth_1.db
    .collection('trips')
    // .where('startDate', '>=', startDateFrom)
    // .where('startDate', '<=', startDateTo)
    // .where('level', 'in', level)
    // .orderBy('startDate')
    .get()
    .then((snapshot) => snapshot.forEach((doc) => {
    let rec = doc.data();
    console.log(rec);
}))
    .then(() => console.log('test'))
    .catch((err) => console.error(err)));
