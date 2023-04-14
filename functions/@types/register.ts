export interface Register {
  tripId: string
  userId: string
  paymentExpireDate: number
  paymentInfo: Payment
  status: number
  createDate: number
  updateDate: number
}

export interface Payment {
  [key: number]: string
  info: string
}
