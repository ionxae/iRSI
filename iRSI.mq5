//+------------------------------------------------------------------+
//|                                                         iRSI.mq5 |
//|                        Copyright 2018, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+

#include <Trade/Trade.mqh>
CTrade m_trade; // Set instance of CTrade

input int      iRSIPeriod  =14;     // RSI Perdio
input int      iRSIHigh    =70;     // RSI Upper Value
input int      iRSILow     =30;     // RSI Lower Value
input double   Volume      =0.01;   // Lotsize 
input int      tpPoints    =100;    // Take Profit in Points

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int OnInit()
  {
//---

//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---

  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---

   double Ask=NormalizeDouble(SymbolInfoDouble(Symbol(),SYMBOL_ASK),_Digits);
   double Bid=NormalizeDouble(SymbolInfoDouble(Symbol(),SYMBOL_BID),_Digits);

   double PriceArray[]; // Price Array for RSI data

   int IRSIDefinition=iRSI(_Symbol,_Period,iRSIPeriod,PRICE_CLOSE);

   ArraySetAsSeries(PriceArray,true);

   CopyBuffer(IRSIDefinition,0,0,3,PriceArray);

   float IRSIValue=PriceArray[0];
   
   if(iRSIPeriod>iRSIHigh)
     {
      m_trade.Buy(Volume,Symbol(),SymbolInfoDouble(Symbol(),SYMBOL_ASK),NULL,(Ask+tpPoints*_Point),NULL);
     }
   if(iRSIPeriod<iRSILow)
     {
      m_trade.Sell(Volume,Symbol(),SymbolInfoDouble(Symbol(),SYMBOL_BID),NULL,(Bid-tpPoints*_Point),NULL);
     }
  }
//+------------------------------------------------------------------+
