import pandas as pd
import requests
import os
import json
import time

#utilizing these tickers 'XOM', 'CVX','COP','EOG','DVN','OXY','TPL','CTRA','KMI','EPD','ET','WMB','OKE','HAL','SLB','BKR','NOV','FANG','HESM','APA'


user_API_key = '###########'



#function to make api calls. specified key metrics.
def get_company_data(symbol):
    url = f'https://www.alphavantage.co/query?function=OVERVIEW&symbol={symbol}&apikey={user_API_key}'
    
    try:
        r = requests.get(url)
        data = r.json()
        company_data = {
            'Symbol': symbol,
            'Name': data.get('Name', 'N/A'),
            'Industry': data.get('Industry'),
            'MarketCap': data.get('MarketCapitalization', 'N/A'),
            'PERatio': data.get('PERatio', 'N/A'),
            'PriceToBookRatio': data.get('PriceToBookRatio', 'N/A'),
            'DividendYield': data.get('DividendYield', 'N/A'),
            'Beta': data.get('Beta', 'N/A'),
            '52WeekLow': data.get('52WeekLow','N/A'),
            'Sector': data.get('Sector','N/A'),
            'Country':  data.get('Country', 'N/A')
}
        return company_data
    except Exception as e:
        print(f"Error Fetching {symbol}: {e}")
        return None

#get data for these specific companies, utilized tickers from upstream, midstream, downstream energy companies.
def get_industry_data():
    
    energy_companies = {
        'XOM', #Exxon Mobil Corporation
        'CVX',  #Chevron Corporation
        'COP',  #ConocoPhillips
        'EOG',  #EOG Resources Inc.
        'DVN',  #Devon Energy Corporation
        'OXY',  #Occidental Petroleum Corporation
        'TPL',  #Texas Pacific Land Corporation
        'CTRA', #Coterra Energy Inc
        'KMI',  #Kinder Morgan, Inc.
        'EPD',  #Enterprise Products Partners L.Partners
        'ET',   #Energy Transfer LP
        'WMB',  #The Williams Companies, Inc.
        'OKE',  #ONEOK, Inc
        'HAL',  #Halliburton Company
        'SLB',  #Schlumberger Limited
        'BKR',  #Baker Hughes Company
        'NOV',  #NOV Inc
        'FANG', #Diamondback Energy
        'HESM', #Hess Midstream LP
        'APA'   #APA Corporation
}
    all_data = []

    print("Starting Data Collection")
    print("="*50)

    for symbol in energy_companies:
        print(f"Starting information pull for {symbol}")
        
        company_data = get_company_data(symbol)
        if company_data:
            all_data.append(company_data)
            print(f"Succesfully pulled {company_data['Name']} - Market Cap {company_data['MarketCap']}")
        else:
            print("error in function")
            None

        time.sleep(15)

    return all_data

#function to pass all information into an excel file utilizing pandas.
def save_as_csv(data, filename='energy companies.csv'):
    df = pd.DataFrame(data)
    df.to_csv(f'{filename}', index=False)
    print("Data saved to E://")
    return df


#main program.
if __name__ == "__main__":
    marketData = get_industry_data()
    if marketData:
        df = save_as_csv(marketData)
    print("--------Finished-------")
    print("=" * 50)
    print(f"Collected data for {len(marketData)} companies")
        
