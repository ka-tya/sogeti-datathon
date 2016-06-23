<h5>Hi,</h5>
<p>I have attached my R script and images for time series. I did not have much time to play with the scales on the axis and sorting.
Since we are diong Tableau, it is definitely easier done there that in R.</p>
<p>Our first ideas was to explore customer data, that's why I have <b>customer clustering</b> over there. 
I figured it might be useful and left it there. There's also some brief research income and age distribution of coupon use.</p>
<p>Next, I desided to concentrate my analysis on products sales fluctuations in time. To see if there are any seasonal sales, etc.
Since there are a lot of products, I've picked the ones that have best sales / most quaninties sold. I was wondering if these are different, but surprisingly they are mostly the same.
I chose 2 product items and created time series analysis as well as decomposition on the time series. The images are attached.
My plan is to use time series forcasting and check if it is possible to do accurate predictions of  future sales. I'll attach these by mid week next week.
The only downside of timeseries analysis I see, is that their plotting is not supported by fancy graphics like ggplot. However, looks like shiny is suppoting ts files as well as another library dygraphs. I'll try it while forecasting.
</p>
<p>I wanted to mention the unit_price "bug" that I came across. I was using the instructions in the pdf file from dunnhumby to calculate price per unit. The two most sellable product items got unit_price of $0.002. This makes me think the data might have been altered. If you'd like to verify and check - I'll be glat!</p>
<h6>UPDATE:</h6>
<p>I have created a forecast for one of the products. I chose the product with best sales, but least quantities. After looking into that product (ID  =  1029743), I noticed the price seems normal (not $0.002), which helped my decision. I have split the data into training and testing. Used the training part to create the forecasting models, while testing was used to check accuracy.

<ul>I used most common forecasting methods, such as:
<li>Mean method. It simply uses average historical value for the forecast, and is used as a validating point for other methods</li>
<li>Naive and Seasonal Naive methods. Naive method  uses last value as the forecast, while seasonal naive method uses last observed value from the same season.</li>
<li>Holt Walters method is based on exponential smooting </li>
<li>Arima method is the most comon one, since usually shows the best accuracy with seasonal data. It is based on moving averages</li>
</ul></p>
<p>Also I attached the image of the forecast (Product_ts3_forecast) and here are the accuracy results:</p>
<table>              <tr> <td>method</td>  <td>RMSE</td>  <td> MAE</td>  <td>MAPE</td> </tr>
<tr>           <td>Mean method</td> <td>27.74</td> <td>25.21</td> <td>29.01</td></tr>
<tr>          <td>Naive method</td> <td>51.03</td> <td>49.34</td> <td>64.93</td></tr>
<tr> <td>Seasonal naive method</td> <td>42.66</td> <td>31.48</td> <td>37.22</td></tr>
<tr>    <td>HoltWinters method</td> <td>26.92</td> <td>23.40</td> <td>31.70</td></tr>
<tr>          <td>Arima method</td> <td>11.38</td>  <td>8.98</td> <td>11.71</td></tr>
</table>
<p>As you can see, Arima performed the best in this case. And it can be used to forecast sales of the product in the future.</p>
<p><b>I'll be posting updates below</b></p>

<p>Thanks,</p>
Katya
