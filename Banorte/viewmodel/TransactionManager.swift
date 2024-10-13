import Foundation
import Combine

class TransactionsManager: ObservableObject {
    @Published var transactions: [Transaction] = [
        Transaction(title: "McDonald's", date: "10 OCT • 11:01 am", amount: "$615.12"),
        Transaction(title: "Transferencia a Santiago", date: "10 OCT • 11:01 am", amount: "$1302.97"),
        Transaction(title: "Pemex", date: "10 OCT • 11:01 am", amount: "$1012.38"),
        Transaction(title: "Volkswagen", date: "10 OCT • 11:01 am", amount: "$615.12"),
        Transaction(title: "Cinemex", date: "11 OCT • 08:30 pm", amount: "$240.00"),
        Transaction(title: "Supermercado Aurrerá", date: "11 OCT • 05:00 pm", amount: "$540.75"),
        Transaction(title: "Uber", date: "12 OCT • 07:15 pm", amount: "$180.25"),
        Transaction(title: "Starbucks", date: "12 OCT • 09:00 am", amount: "$95.00"),
        Transaction(title: "Rappi", date: "13 OCT • 12:30 pm", amount: "$450.50"),
        Transaction(title: "Amazon", date: "13 OCT • 04:45 pm", amount: "$850.99"),
        Transaction(title: "Spotify", date: "14 OCT • 09:00 am", amount: "$99.00"),
        Transaction(title: "Netflix", date: "15 OCT • 08:00 am", amount: "$149.00"),
        Transaction(title: "Apple Store", date: "15 OCT • 02:30 pm", amount: "$299.99"),
        Transaction(title: "Gas Natural", date: "16 OCT • 10:45 am", amount: "$350.00"),
        Transaction(title: "CFE", date: "17 OCT • 11:15 am", amount: "$780.50"),
        Transaction(title: "Telcel", date: "18 OCT • 01:20 pm", amount: "$399.00"),
        Transaction(title: "Liverpool", date: "19 OCT • 03:50 pm", amount: "$1,200.00"),
        Transaction(title: "Restaurante El Portón", date: "20 OCT • 07:30 pm", amount: "$650.75"),
        Transaction(title: "OXXO", date: "21 OCT • 09:15 pm", amount: "$200.00"),
        Transaction(title: "Farmacias Guadalajara", date: "22 OCT • 05:40 pm", amount: "$320.60"),
    ]
}
