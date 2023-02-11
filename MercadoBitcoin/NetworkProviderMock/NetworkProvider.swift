//
//  NetworkProvider.swift
//  MercadoBitcoin
//
//  Created by Junior Silva on 08/02/23.
//

import Foundation

protocol NetworkProviderProtocol: AnyObject {
    func fetchData(_ endpoint: Endpoint, completion: @escaping (Result<[Bitcoin], NetworkError>) -> Void)
}

final class NetworkProvider: NetworkProviderProtocol {
    private init() {}
    static let shared = NetworkProvider()
    
    func fetchData(_ endpoint: Endpoint, completion: @escaping (Result<[Bitcoin], NetworkError>) -> Void) {
        guard let url = endpoint.url else {
            completion(.failure(.invalidEndpoint))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(Bundle.main.apiKey, forHTTPHeaderField: "X-CoinAPI-Key")
        
        loadUrlAndDecode(request, completion: completion)
    }
    
    private func loadUrlAndDecode<T: Decodable>(_ url: URLRequest, completion: @escaping (Result<T, NetworkError>) -> Void) {
        let json = """
        [
            {
                "exchange_id": "BINANCE",
                "website": "https://www.binance.com/",
                "name": "Binance",
                "data_start": "2017-07-14",
                "data_end": "2023-02-10",
                "data_quote_start": "2017-12-18T21:50:58.3910192Z",
                "data_quote_end": "2023-02-10T00:00:00.0000000Z",
                "data_orderbook_start": "2017-12-18T21:50:58.3910192Z",
                "data_orderbook_end": "2023-02-10T00:00:00.0000000Z",
                "data_trade_start": "2017-07-14T04:00:00.3760000Z",
                "data_trade_end": "2023-02-10T00:00:00.0000000Z",
                "data_symbols_count": 2148,
                "volume_1hrs_usd": 487932622.73,
                "volume_1day_usd": 20486813096.94,
                "volume_1mth_usd": 538775124586.77
            },
            {
                "exchange_id": "KRAKEN",
                "website": "https://www.kraken.com/",
                "name": "Kraken",
                "data_start": "2013-10-22",
                "data_end": "2023-02-10",
                "data_quote_start": "2014-07-31T13:05:46.0000000Z",
                "data_quote_end": "2023-02-10T00:00:00.0000000Z",
                "data_orderbook_start": "2014-07-31T13:05:46.0000000Z",
                "data_orderbook_end": "2023-02-10T00:00:00.0000000Z",
                "data_trade_start": "2013-10-22T23:09:46.8630000Z",
                "data_trade_end": "2023-02-10T00:00:00.0000000Z",
                "data_symbols_count": 786,
                "volume_1hrs_usd": 613766570.72,
                "volume_1day_usd": 8942343282.96,
                "volume_1mth_usd": 278300523090.44
            },
            {
                "exchange_id": "COINBASE",
                "website": "https://pro.coinbase.com/",
                "name": "Coinbase Pro (GDAX)",
                "data_start": "2015-01-14",
                "data_end": "2023-02-10",
                "data_quote_start": "2015-05-17T00:51:32.6370000Z",
                "data_quote_end": "2023-02-10T00:00:00.0000000Z",
                "data_orderbook_start": "2015-05-17T00:51:32.6370000Z",
                "data_orderbook_end": "2023-02-10T00:00:00.0000000Z",
                "data_trade_start": "2015-01-14T16:07:05.0000000Z",
                "data_trade_end": "2023-02-10T00:00:00.0000000Z",
                "data_symbols_count": 651,
                "volume_1hrs_usd": 43210423.65,
                "volume_1day_usd": 1530774758.05,
                "volume_1mth_usd": 59390245097.25
            },
            {
                "exchange_id": "BITSTAMP",
                "website": "https://www.bitstamp.net/",
                "name": "Bitstamp Ltd.",
                "data_start": "2011-09-13",
                "data_end": "2023-02-10",
                "data_quote_start": "2014-02-24T17:43:05.0000000Z",
                "data_quote_end": "2023-02-10T00:00:00.0000000Z",
                "data_orderbook_start": "2014-02-24T17:43:05.0000000Z",
                "data_orderbook_end": "2023-02-10T00:00:00.0000000Z",
                "data_trade_start": "2011-09-13T13:53:36.0000000Z",
                "data_trade_end": "2023-02-10T00:00:00.0000000Z",
                "data_symbols_count": 197,
                "volume_1hrs_usd": 1502324.13,
                "volume_1day_usd": 116771292.74,
                "volume_1mth_usd": 4696931205.78
            },
            {
                "exchange_id": "GEMINI",
                "website": "https://gemini.com/",
                "name": "Gemini",
                "data_start": "2015-10-08",
                "data_end": "2023-02-10",
                "data_quote_start": "2017-03-18T22:53:42.0948480Z",
                "data_quote_end": "2023-02-10T00:00:00.0000000Z",
                "data_orderbook_start": "2017-03-18T22:53:42.0948480Z",
                "data_orderbook_end": "2023-02-10T00:00:00.0000000Z",
                "data_trade_start": "2015-10-08T13:40:07.8010000Z",
                "data_trade_end": "2023-02-10T00:00:00.0000000Z",
                "data_symbols_count": 158,
                "volume_1hrs_usd": 1450166.83,
                "volume_1day_usd": 185442172.89,
                "volume_1mth_usd": 7589293476.26,
                "metric_id": [
                    "AUCTION_COLLAR_PRICE",
                    "AUCTION_HIGHEST_BID",
                    "AUCTION_LOWEST_ASK",
                    "AUCTION_PRICE",
                    "AUCTION_QUANTITY",
                    "AUCTION_RESULT",
                    "SYMBOL_DETAILS_MIN_ORDER_SIZE",
                    "SYMBOL_DETAILS_QUOTE_INCREMENT",
                    "SYMBOL_DETAILS_STATUS",
                    "SYMBOL_DETAILS_TICK_SIZE",
                    "SYMBOL_DETAILS_WRAP_ENABLED"
                ]
            },
            {
                "exchange_id": "LMAXDIGITAL",
                "website": "https://www.lmaxdigital.com/",
                "name": "LMAX Digital",
                "data_start": "2020-12-03",
                "data_end": "2022-10-10",
                "data_quote_start": "2020-12-03T00:00:00.0000000Z",
                "data_quote_end": "2022-10-10T00:00:00.0000000Z",
                "data_orderbook_start": "2022-01-02T00:00:00.0000000Z",
                "data_orderbook_end": "2022-10-10T00:00:00.0000000Z",
                "data_trade_start": "2020-12-03T00:00:00.0000000Z",
                "data_trade_end": "2022-10-10T00:00:00.0000000Z",
                "data_symbols_count": 16,
                "volume_1hrs_usd": 0,
                "volume_1day_usd": 0,
                "volume_1mth_usd": 0
            },
            {
                "exchange_id": "ECB",
                "website": "https://www.ecb.europa.eu/",
                "name": "European Central Bank",
                "data_start": "2020-08-31",
                "data_end": "2023-02-10",
                "data_quote_start": "2020-08-31T00:00:00.0000000Z",
                "data_quote_end": "2023-02-10T00:00:00.0000000Z",
                "data_trade_start": "2022-06-06T14:00:00.0000000Z",
                "data_trade_end": "2022-06-10T14:00:00.0000000Z",
                "data_symbols_count": 32,
                "volume_1hrs_usd": 0,
                "volume_1day_usd": 0,
                "volume_1mth_usd": 0
            },
            {
                "exchange_id": "OKCOINCNY",
                "website": "https://www.okcoin.cn/",
                "name": "OKCoin CNY",
                "data_start": "2013-06-12",
                "data_end": "2018-03-09",
                "data_quote_start": "2015-02-15T12:53:50.3430000Z",
                "data_quote_end": "2018-03-09T23:34:52.5800000Z",
                "data_orderbook_start": "2015-02-15T12:53:50.3430000Z",
                "data_orderbook_end": "2018-03-09T23:34:52.5800000Z",
                "data_trade_start": "2013-06-12T14:24:24.0000000Z",
                "data_trade_end": "2017-11-01T16:30:39.7077259Z",
                "data_symbols_count": 2,
                "volume_1hrs_usd": 0,
                "volume_1day_usd": 0,
                "volume_1mth_usd": 0
            },
            {
                "exchange_id": "HUOBI",
                "website": "https://www.huobi.us/",
                "name": "Huobi (HBUS)",
                "data_start": "2015-03-29",
                "data_end": "2020-03-30",
                "data_quote_start": "2015-03-29T21:46:06.2630000Z",
                "data_quote_end": "2020-03-30T08:40:10.1306733Z",
                "data_orderbook_start": "2015-03-29T21:46:06.2630000Z",
                "data_orderbook_end": "2020-03-30T08:40:10.1306733Z",
                "data_trade_start": "2015-03-29T21:46:08.7030000Z",
                "data_trade_end": "2019-12-16T00:23:43.4240000Z",
                "data_symbols_count": 777,
                "volume_1hrs_usd": 0,
                "volume_1day_usd": 0,
                "volume_1mth_usd": 0
            },
            {
                "exchange_id": "BITTREX",
                "website": "https://bittrex.com/",
                "name": "Bittrex",
                "data_start": "2017-01-26",
                "data_end": "2023-02-10",
                "data_quote_start": "2017-03-14T20:03:47.4782440Z",
                "data_quote_end": "2023-02-10T00:00:00.0000000Z",
                "data_orderbook_start": "2017-03-14T20:03:47.4782440Z",
                "data_orderbook_end": "2023-02-10T00:00:00.0000000Z",
                "data_trade_start": "2017-01-26T19:48:55.0000000Z",
                "data_trade_end": "2023-02-10T00:00:00.0000000Z",
                "data_symbols_count": 1737,
                "volume_1hrs_usd": 739689.29,
                "volume_1day_usd": 9618457.07,
                "volume_1mth_usd": 6798193650.64
            },
            {
                "exchange_id": "POLONIEX",
                "website": "https://poloniex.com/",
                "name": "POLONIEX",
                "data_start": "2016-05-29",
                "data_end": "2023-02-10",
                "data_quote_start": "2016-06-12T11:53:38.1523879Z",
                "data_quote_end": "2023-02-10T00:00:00.0000000Z",
                "data_orderbook_start": "2016-06-12T11:53:38.1523879Z",
                "data_orderbook_end": "2023-02-10T00:00:00.0000000Z",
                "data_trade_start": "2016-05-29T15:05:08.0000000Z",
                "data_trade_end": "2022-08-02T00:00:00.0000000Z",
                "data_symbols_count": 771,
                "volume_1hrs_usd": 0,
                "volume_1day_usd": 0,
                "volume_1mth_usd": 0
            },
            {
                "exchange_id": "HUOBIPRO",
                "website": "https://www.hbg.com/",
                "name": "Huobi Global",
                "data_start": "2018-01-22",
                "data_end": "2023-02-10",
                "data_quote_start": "2018-01-24T00:22:17.2456560Z",
                "data_quote_end": "2023-02-10T00:00:00.0000000Z",
                "data_orderbook_start": "2018-01-24T00:22:17.2456560Z",
                "data_orderbook_end": "2023-02-10T00:00:00.0000000Z",
                "data_trade_start": "2018-01-22T12:55:12.5650000Z",
                "data_trade_end": "2023-02-10T00:00:00.0000000Z",
                "data_symbols_count": 1543,
                "volume_1hrs_usd": 123541381.64,
                "volume_1day_usd": 3119396119.19,
                "volume_1mth_usd": 420128676254.58
            },
            {
                "exchange_id": "HITBTC",
                "website": "https://hitbtc.com/",
                "name": "HitBTC",
                "data_start": "2013-12-27",
                "data_end": "2023-02-10",
                "data_quote_start": "2017-03-18T22:53:44.4091161Z",
                "data_quote_end": "2023-02-10T00:00:00.0000000Z",
                "data_orderbook_start": "2017-03-18T22:53:44.4091161Z",
                "data_orderbook_end": "2023-02-10T00:00:00.0000000Z",
                "data_trade_start": "2013-12-27T08:23:37.0000000Z",
                "data_trade_end": "2023-02-10T00:00:00.0000000Z",
                "data_symbols_count": 2703,
                "volume_1hrs_usd": 22193015.09,
                "volume_1day_usd": 754048028.84,
                "volume_1mth_usd": 32903118949.55
            },
            {
                "exchange_id": "BTCCHINA",
                "website": "https://www.btcchina.com/",
                "name": "BTCCHINA",
                "data_start": "2011-06-13",
                "data_end": "2019-02-06",
                "data_quote_start": "2015-03-29T04:20:18.0000000Z",
                "data_quote_end": "2019-02-06T15:48:55.5557396Z",
                "data_orderbook_start": "2015-03-29T04:20:18.0000000Z",
                "data_orderbook_end": "2019-02-06T15:48:55.5557396Z",
                "data_trade_start": "2011-06-13T05:13:24.0000000Z",
                "data_trade_end": "2018-03-09T22:06:20.0000000Z",
                "data_symbols_count": 3,
                "volume_1hrs_usd": 0,
                "volume_1day_usd": 0,
                "volume_1mth_usd": 0
            },
            {
                "exchange_id": "BITFLYER",
                "website": "https://bitflyer.jp/",
                "name": "bitFlyer (replaced by BITFLYERLTNG)",
                "data_start": "2017-11-28",
                "data_end": "2020-07-26",
                "data_quote_start": "2017-11-29T01:10:28.2891461Z",
                "data_quote_end": "2020-07-26T21:52:04.1273385Z",
                "data_orderbook_start": "2017-11-29T01:10:28.2891461Z",
                "data_orderbook_end": "2020-07-26T21:52:04.1273385Z",
                "data_trade_start": "2017-11-28T03:22:58.0000000Z",
                "data_trade_end": "2020-07-26T21:50:16.0000000Z",
                "data_symbols_count": 136,
                "volume_1hrs_usd": 0,
                "volume_1day_usd": 0,
                "volume_1mth_usd": 0
            },
            {
                "exchange_id": "BITHUMB",
                "website": "https://www.bithumb.com/",
                "name": "BITHUMB",
                "data_start": "2017-09-21",
                "data_end": "2023-02-10",
                "data_quote_start": "2017-09-21T13:50:30.0371289Z",
                "data_quote_end": "2023-02-10T00:00:00.0000000Z",
                "data_orderbook_start": "2017-09-21T13:50:30.0371289Z",
                "data_orderbook_end": "2023-02-10T00:00:00.0000000Z",
                "data_trade_start": "2017-09-21T13:43:23.0000000Z",
                "data_trade_end": "2023-02-10T00:00:00.0000000Z",
                "data_symbols_count": 304,
                "volume_1hrs_usd": 16251071.95,
                "volume_1day_usd": 397305700.98,
                "volume_1mth_usd": 16280538191.93
            },
            {
                "exchange_id": "COINONE",
                "website": "https://coinone.co.kr/",
                "name": "coinone",
                "data_start": "2017-09-20",
                "data_end": "2023-02-10",
                "data_quote_start": "2017-09-21T13:36:45.5891048Z",
                "data_quote_end": "2023-02-10T00:00:00.0000000Z",
                "data_orderbook_start": "2017-09-21T13:36:45.5891048Z",
                "data_orderbook_end": "2023-02-10T00:00:00.0000000Z",
                "data_trade_start": "2017-09-20T13:37:21.0000000Z",
                "data_trade_end": "2023-02-10T00:00:00.0000000Z",
                "data_symbols_count": 9,
                "volume_1hrs_usd": 988744.99,
                "volume_1day_usd": 44096001.81,
                "volume_1mth_usd": 1140105476.58
            },
            {
                "exchange_id": "OKEX",
                "website": "https://www.okex.com/",
                "name": "OKEx",
                "data_start": "2017-12-01",
                "data_end": "2023-02-10",
                "data_quote_start": "2017-12-18T21:01:51.6121385Z",
                "data_quote_end": "2023-02-10T00:00:00.0000000Z",
                "data_orderbook_start": "2017-12-18T21:01:51.6121385Z",
                "data_orderbook_end": "2023-02-10T00:00:00.0000000Z",
                "data_trade_start": "2017-12-01T15:26:32.0000000Z",
                "data_trade_end": "2023-02-10T00:00:00.0000000Z",
                "data_symbols_count": 55866,
                "volume_1hrs_usd": 1882695743.13,
                "volume_1day_usd": 39198494669.28,
                "volume_1mth_usd": 900291919868.45,
                "metric_id": [
                    null,
                    "DERIVATIVES_FUNDING_RATE_CURRENT",
                    "DERIVATIVES_FUNDING_RATE_NEXT",
                    "DERIVATIVES_FUNDING_TIME",
                    "DERIVATIVES_MARK_PRICE",
                    "DERIVATIVES_SETTLEMENT_PRICE",
                    "LIQUIDATION_CURRENCY",
                    "LIQUIDATION_INSTRUMENT_ID",
                    "LIQUIDATION_INSTRUMENT_TYPE",
                    "LIQUIDATION_NUMBER_OF_LOSSES",
                    "LIQUIDATION_POSITION_SIDE",
                    "LIQUIDATION_PRICE",
                    "LIQUIDATION_QUANTITY",
                    "LIQUIDATION_SIDE",
                    "LIQUIDATION_TIME",
                    "LIQUIDATION_TOTAL_LOSS"
                ]
            },
            {
                "exchange_id": "OKCOINUSD",
                "website": "https://www.okcoin.com/",
                "name": "OKCoin USD",
                "data_start": "2015-02-14",
                "data_end": "2023-02-10",
                "data_quote_start": "2015-02-15T12:53:46.6330000Z",
                "data_quote_end": "2023-02-10T00:00:00.0000000Z",
                "data_orderbook_start": "2015-02-15T12:53:46.6330000Z",
                "data_orderbook_end": "2023-02-10T00:00:00.0000000Z",
                "data_trade_start": "2015-02-14T16:15:05.5900000Z",
                "data_trade_end": "2023-02-10T00:00:00.0000000Z",
                "data_symbols_count": 109,
                "volume_1hrs_usd": 67297.35,
                "volume_1day_usd": 8856700.06,
                "volume_1mth_usd": 394878892.78
            },
            {
                "exchange_id": "BTCTRADE",
                "website": "https://www.btctrade.com/",
                "name": "BTCTRADE",
                "data_start": "2015-05-17",
                "data_end": "2019-02-06",
                "data_quote_start": "2015-05-17T14:57:14.3470000Z",
                "data_quote_end": "2019-02-06T15:50:53.7510625Z",
                "data_orderbook_start": "2015-05-17T14:57:14.3470000Z",
                "data_orderbook_end": "2019-02-06T15:50:53.7510625Z",
                "data_trade_start": "2015-05-17T15:04:12.0000000Z",
                "data_trade_end": "2018-03-09T21:52:49.0000000Z",
                "data_symbols_count": 6,
                "volume_1hrs_usd": 0,
                "volume_1day_usd": 0,
                "volume_1mth_usd": 0
            },
            {
                    "exchange_id": "BITMEX",
                    "website": "https://www.bitmex.com/",
                    "name": "BitMEX",
                    "data_start": "2014-11-22",
                    "data_end": "2023-02-10",
                    "data_quote_start": "2014-11-22T16:58:47.8820780Z",
                    "data_quote_end": "2023-02-10T00:00:00.0000000Z",
                    "data_orderbook_start": "2014-11-22T16:58:47.8820780Z",
                    "data_orderbook_end": "2023-02-10T00:00:00.0000000Z",
                    "data_trade_start": "2014-11-22T17:51:38.9484710Z",
                    "data_trade_end": "2023-02-10T00:00:00.0000000Z",
                    "data_symbols_count": 429,
                    "volume_1hrs_usd": 704878378328.64,
                    "volume_1day_usd": 174543013473240.40,
                    "volume_1mth_usd": 3271806940318219.18,
                    "metric_id": [
                        "LIQUIDATION_ORDER_ID",
                        "LIQUIDATION_PRICE",
                        "LIQUIDATION_QUANTITY",
                        "LIQUIDATION_SIDE",
                        "LIQUIDATION_SYMBOL"
                    ]
                },
                {
                    "exchange_id": "KUCOIN",
                    "website": "https://kucoin.com/",
                    "name": "Kucoin",
                    "data_start": "2018-01-24",
                    "data_end": "2023-02-10",
                    "data_quote_start": "2018-01-24T00:22:08.7776711Z",
                    "data_quote_end": "2023-02-10T00:00:00.0000000Z",
                    "data_orderbook_start": "2018-01-24T00:22:08.7776711Z",
                    "data_orderbook_end": "2023-02-10T00:00:00.0000000Z",
                    "data_trade_start": "2018-01-24T15:12:15.0000000Z",
                    "data_trade_end": "2023-02-10T00:00:00.0000000Z",
                    "data_symbols_count": 1812,
                    "volume_1hrs_usd": 178536768.41,
                    "volume_1day_usd": 1619460177.90,
                    "volume_1mth_usd": 86941242931.54
                },
                {
                    "exchange_id": "ITBIT",
                    "website": "https://www.itbit.com/",
                    "name": "itBit",
                    "data_start": "2013-08-25",
                    "data_end": "2023-02-10",
                    "data_quote_start": "2015-05-26T18:24:28.9330000Z",
                    "data_quote_end": "2023-02-10T00:00:00.0000000Z",
                    "data_orderbook_start": "2015-05-26T18:24:28.9330000Z",
                    "data_orderbook_end": "2023-02-10T00:00:00.0000000Z",
                    "data_trade_start": "2013-08-25T00:21:44.0000000Z",
                    "data_trade_end": "2023-02-10T00:00:00.0000000Z",
                    "data_symbols_count": 9,
                    "volume_1hrs_usd": 401257.03,
                    "volume_1day_usd": 6276402.85,
                    "volume_1mth_usd": 321255769.41
                },
                {
                    "exchange_id": "DERIBIT",
                    "website": "https://www.deribit.com/",
                    "name": "Deribit",
                    "data_start": "2016-12-02",
                    "data_end": "2023-02-10",
                    "data_quote_start": "2017-03-14T20:03:36.9946659Z",
                    "data_quote_end": "2023-02-10T00:00:00.0000000Z",
                    "data_orderbook_start": "2017-03-14T20:03:36.9946659Z",
                    "data_orderbook_end": "2023-02-10T00:00:00.0000000Z",
                    "data_trade_start": "2016-12-02T05:15:13.4340000Z",
                    "data_trade_end": "2023-02-10T00:00:00.0000000Z",
                    "data_symbols_count": 103485,
                    "volume_1hrs_usd": 8037118767.13,
                    "volume_1day_usd": 671479445773.02,
                    "volume_1mth_usd": 20660666247054.48,
                    "metric_id": [
                        "DERIVATIVES_DELIVERY_PRICE",
                        "DERIVATIVES_FUNDING_RATE_CURRENT",
                        "DERIVATIVES_FUNDING_RATE_NEXT",
                        "DERIVATIVES_INDEX_PRICE",
                        "DERIVATIVES_INDEX_PRICE",
                        "DERIVATIVES_MARK_PRICE",
                        "DERIVATIVES_MARK_PRICE_IV",
                        "DERIVATIVES_OPEN_INTEREST",
                        "DERIVATIVES_SETTLEMENT_PRICE",
                        "GREEKS_DELTA",
                        "GREEKS_GAMMA",
                        "GREEKS_RHO",
                        "GREEKS_THETA",
                        "GREEKS_VEGA",
                        "IV_ASK",
                        "IV_BID",
                        "IV_INTEREST_RATE",
                        "IV_UNDERLYING_PRICE",
                        "LIQUIDATION_INDEX_PRICE",
                        "LIQUIDATION_IV",
                        "LIQUIDATION_MARK_PRICE",
                        "LIQUIDATION_POSITION_ID",
                        "LIQUIDATION_PRICE",
                        "LIQUIDATION_QUANTITY",
                        "LIQUIDATION_SIDE",
                        "LIQUIDATION_SYMBOL",
                        "LIQUIDATION_TICK_DIRECTION",
                        "LIQUIDATION_TIME"
                    ]
                },
                {
                    "exchange_id": "BITBAY",
                    "website": " https://zondaglobal.com/",
                    "name": "Zonda (BitBay)",
                    "data_start": "2014-03-29",
                    "data_end": "2023-02-10",
                    "data_quote_start": "2017-08-29T15:47:11.6744609Z",
                    "data_quote_end": "2023-02-10T00:00:00.0000000Z",
                    "data_orderbook_start": "2017-08-29T15:47:11.6744609Z",
                    "data_orderbook_end": "2023-02-10T00:00:00.0000000Z",
                    "data_trade_start": "2014-03-29T12:36:43.0000000Z",
                    "data_trade_end": "2023-02-10T00:00:00.0000000Z",
                    "data_symbols_count": 291,
                    "volume_1hrs_usd": 44857.96,
                    "volume_1day_usd": 1441388.41,
                    "volume_1mth_usd": 81349750.19,
                    "metric_id": [
                        "STATS_PRICE_HIGH_LAST_24H",
                        "STATS_PRICE_LOW_LAST_24H",
                        "STATS_VOLUME_SUM_LAST_24H"
                    ]
                },
                {
                    "exchange_id": "BIBOX",
                    "website": "https://www.bibox.com/",
                    "name": "Bibox",
                    "data_start": "2018-11-20",
                    "data_end": "2022-08-13",
                    "data_quote_start": "2018-11-27T00:44:52.1671444Z",
                    "data_quote_end": "2022-08-13T00:00:00.0000000Z",
                    "data_orderbook_start": "2018-11-27T00:44:52.1671444Z",
                    "data_orderbook_end": "2022-08-13T00:00:00.0000000Z",
                    "data_trade_start": "2018-11-20T18:52:30.0000000Z",
                    "data_trade_end": "2022-08-13T00:00:00.0000000Z",
                    "data_symbols_count": 962,
                    "volume_1hrs_usd": 0,
                    "volume_1day_usd": 0,
                    "volume_1mth_usd": 0
                },
                {
                    "exchange_id": "KUCOINFTS",
                    "website": "https://futures.kucoin.com/",
                    "name": "Kucoin Futures",
                    "data_start": "2022-03-28",
                    "data_end": "2023-02-10",
                    "data_quote_start": "2022-03-28T14:58:10.1050000Z",
                    "data_quote_end": "2023-02-10T00:00:00.0000000Z",
                    "data_orderbook_start": "2022-05-14T00:00:00.0000000Z",
                    "data_orderbook_end": "2023-02-10T00:00:00.0000000Z",
                    "data_trade_start": "2022-03-28T14:58:09.8732920Z",
                    "data_trade_end": "2023-02-10T00:00:00.0000000Z",
                    "data_symbols_count": 145,
                    "volume_1hrs_usd": 4974669238.27,
                    "volume_1day_usd": 171585745863.63,
                    "volume_1mth_usd": 6866301364199.72,
                    "metric_id": [
                        "DERIVATIVES_FUNDING_RATE_CURRENT",
                        "DERIVATIVES_FUNDING_RATE_CURRENT",
                        "DERIVATIVES_INDEX_PRICE",
                        "DERIVATIVES_INDEX_PRICE",
                        "DERIVATIVES_MARK_PRICE"
                    ]
                },
                {
                    "exchange_id": "UPBIT",
                    "website": "https://upbit.com/",
                    "name": "UPbit Korea",
                    "data_start": "2018-08-20",
                    "data_end": "2023-02-10",
                    "data_quote_start": "2018-08-20T23:03:42.8653704Z",
                    "data_quote_end": "2023-02-10T00:00:00.0000000Z",
                    "data_orderbook_start": "2018-08-20T23:03:42.8653704Z",
                    "data_orderbook_end": "2023-02-10T00:00:00.0000000Z",
                    "data_trade_start": "2018-08-20T00:00:58.5670000Z",
                    "data_trade_end": "2023-02-10T00:00:00.0000000Z",
                    "data_symbols_count": 553,
                    "volume_1hrs_usd": 29272276.18,
                    "volume_1day_usd": 1183602161.70,
                    "volume_1mth_usd": 37705051487.83
                },
                {
                    "exchange_id": "BINANCEUS",
                    "website": "https://www.binance.us/",
                    "name": "Binance US",
                    "data_start": "2019-10-09",
                    "data_end": "2023-02-10",
                    "data_quote_start": "2019-10-09T13:14:23.9239466Z",
                    "data_quote_end": "2023-02-10T00:00:00.0000000Z",
                    "data_orderbook_start": "2019-10-09T13:14:23.9239466Z",
                    "data_orderbook_end": "2023-02-10T00:00:00.0000000Z",
                    "data_trade_start": "2019-10-09T13:14:47.5920000Z",
                    "data_trade_end": "2023-02-10T00:00:00.0000000Z",
                    "data_symbols_count": 504,
                    "volume_1hrs_usd": 11207611.49,
                    "volume_1day_usd": 469074734.77,
                    "volume_1mth_usd": 12481628631.35
                },
                {
                    "exchange_id": "CRYPTOPIA",
                    "website": "https://www.cryptopia.co.nz/",
                    "name": "Cryptopia",
                    "data_start": "2014-12-07",
                    "data_end": "2019-05-14",
                    "data_quote_start": "2017-03-14T20:03:49.1491232Z",
                    "data_quote_end": "2019-05-14T04:39:36.3417482Z",
                    "data_orderbook_start": "2017-03-14T20:03:49.1491232Z",
                    "data_orderbook_end": "2019-05-14T04:39:36.3417482Z",
                    "data_trade_start": "2014-12-07T20:04:05.0000000Z",
                    "data_trade_end": "2019-05-14T04:38:57.0000000Z",
                    "data_symbols_count": 4659,
                    "volume_1hrs_usd": 0,
                    "volume_1day_usd": 0,
                    "volume_1mth_usd": 0
                },
        ]
        """.data(using: .utf8)!
        
                let decodedResponse = try! JSONDecoder().decode(T.self, from: json)
                self.executeCompletionHandler(with: .success(decodedResponse), completion: completion)
    }
    
    private func executeCompletionHandler<T: Decodable>(with result: Result<T, NetworkError>, completion: @escaping (Result<T, NetworkError>) -> Void) {
        DispatchQueue.main.async {
            completion(result)
        }
    }
}