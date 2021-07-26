# import urllib.request
from workflow import Workflow, ICON_WEB, ICON_ERROR, web


def format_strings_from_quote(ticker, quote_data):
    data = quote_data["RAW"][ticker.upper()]["USD"]
    price = "{:,.2f}".format(data["PRICE"])
    high = "{:,.2f}".format(data["HIGH24HOUR"])
    low = "{:,.2f}".format(data["LOW24HOUR"])
    change = "{:,.2f}".format(data["CHANGEPCT24HOUR"])
    formatted = {}
    formatted['title'] = ticker.upper() + ': $' + price + ' (' + change + '%)'
    formatted['subtitle'] = '24hr High: $' + high + ' 24hr low $' + low
    return formatted


if __name__ == u"__main__":
    url = 'https://min-api.cryptocompare.com/data/price?fsym=ZRX&tsyms=USD'
    # r = urllib.request.urlopen(url).read()
    # print(r)

    j = web.get(url).json()
    print(j)

    url = 'https://min-api.cryptocompare.com/data/pricemultifull?fsyms=ZRX&tsyms=USD'
    j = web.get(url).json()
    print(format_strings_from_quote("ZRX", j))
    # r = urllib.request.urlopen(url).read()
    # print(r)
