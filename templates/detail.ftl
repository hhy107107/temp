<!DOCTYPE html>
<html>
<head>
	<title>咖啡机移动端</title>
	<meta charset="UTF-8">
	<meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" href="${staticPath}/css/adapter.css">
    <link rel="stylesheet" href="${staticPath}/css/weui.css">
    <script type="text/javascript" src="${staticPath}/js/vue.js"></script>
    <script type="text/javascript" src="${staticPath}/js/weui.js"></script>
    <script type="text/javascript" src="${staticPath}/js/vue-lazyload.js"></script>
    <script type="text/javascript" src="${staticPath}/js/vue-cookies.js"></script>
    <script type="text/javascript" src="${staticPath}/js/axios.js"></script>
    <script type="text/javascript" src="${staticPath}/js/server.js"></script>
    <script type="text/javascript" src="${staticPath}/js/jweixin.js"></script>
    <style type="text/css">
    	  .detail-constent{
    	  	  width:100%;
/*    	  	  background:#ECECEC;*/
    	   }
    	   .detail-constent-img{
    	   	  width:100%;
    	   	  height:auto;
    	   	  background-color:#FFFFFF;
    	   	  text-align: center;
    	   	  margin-bottom:0.5rem;
    	   }
    	   .detail-constent-img img{
    	   	    width:100%;
    	   }
    	   .detail-constent-title{
    	   	  width:100%;
    	   	  background-color: #fff;
    	   }
    	   .constent-title-left{
    	   	     width:90%;
    	   	     margin:0 auto;
    	   	     text-align: center; 
    	   }
    	   .constent-title-left h3{
    	   	    line-height:1.8rem;
    	   	    color:rgb(160,90,40);
    	   	     word-wrap: break-word;  
    	   }
    	    .constent-title-left p{
    	    	color: #CCCCCC;
    	    	font-size:1rem ;
    	    	word-wrap: break-word; 
    	    }
    	   .constent-price span{
    	   	    text-align: center;
    	   	    color: rgb(160,90,40);
    	   } 
            .constent-price-sale{
            	margin:0.5rem auto;
            	text-align:left;
            	font-size:1.5rem;	
    	    }
    	    .constent-price i{
    	    	font-size:0.5rem;
    	    }
             .constent-price-detail p{
             	color:rgb(160,90,40);
             	font-weight: bold;
             }
             .constent-price-detail  span{
             	font-size:1.5rem;
             	font-weight:600 ;
             }
             .constent-button{
             	margin:1rem auto;
             	text-align:center;
             }
             .constent-button button{
             	width:35%;
             	height:3rem;
             	color:white;
             	border:hidden;
             	border-radius:1.5rem;
                outline:none;
             }
             button:nth-child(1){
             	background-color:green;
             }
             button:nth-child(2){
             	background-color:rgb(160,90,40);
             	vertical-align:top;
             }
             button:nth-child(2) span{
             	 display:block;
             	 font-size:12px;
             }
             .constent-price-logo{
             	width:2rem;
             	height:2rem;
             }
              .constent-price-logo img{
             	width:100%;
             	height:100%;
             }
    </style>
</head>
<body>
	<div id="app">
		<div class="detail-constent">
			 <div class="detail-constent-img">
			 	 <img  v-lazy="goods.goodsImg"/>
			 </div>
			   
			 <div class="detail-constent-title">
			 	  <div class="constent-title-left">
			 	  	   <h3  align="left">{{goods.goodsName}}</h3>
			 	  	   <p align="left">{{goods.goodsDesc}}</p>
			 	  
			 	    <div class="constent-price">
			                <div class="constent-price-sale">
			                    <span><i>￥</i>{{goods.goodsPrice}}</span>
			                   
			                    <div class="constent-price-logo fr">
			                    	<img src="${staticPath}/images/index/热卖icon@3x.png"  v-show="goods.hot"/>
			                    </div>
			                </div>
				 	  	    <div class="constent-price-detail">
				 	  	    	<p>支付金额:  <i>￥</i><span>{{goods.goodsPrice}}</span></p>
				 	  	   	</div>
			 	    </div>
			 	  </div>
			 	  <div class="constent-button">
			 	  	  <button @click="pay(1)">微信支付</button>
			 	  	  <button @click="pay(2)">
			 	  	  	余额支付
			 	  	  	  <span>余额￥<i>${balance}<i></span>
			 	  	  </button>
			 	  </div>
			 </div>
		</div>
	</div>
</body>
</html>

<script>
    Vue.use(VueLazyload, {
      preLoad: 1.3,
      error: './images/index/商品详情主图占位图@3x.png',
      loading: './images/index/商品详情主图占位图@3x.png',
      attempt: 3
    })

	var app = new Vue({
        el: '#app',
        data(){
            return{
            	goods:{}
            }
        },mounted(){
         	this.pullgoodsDetail();
         },
         methods:{
         	async pullgoodsDetail(){
         		var _this = this;
         		await axios.get('${apiPath}/goods/detail',{
                    params:{
                      goodsId:getQueryString("goodsId"),
                    }
                }).then(function(res){            
                    if (res.data.code==1){
                        _this.goods=res.data.result
                      console.log(_this.goods);
                    }
                }).catch(function(err){
                    alert('获取商品详情失败: '+err.message);
                })
         	},
            pay(payType){
                var _this = this;
                axios.get('${apiPath}/order/commit',{
                    params:{
                      orderPrice:_this.goods.goodsPrice,
                      payType:payType,
                      goodsInfo:{
                        goodsId:_this.goods.id,
                        goodsNum:1
                      }
                    }
                }).then(function(res){            
                    if (res.data.code==1){
                        if (payType==1){
                            _this.awakeWechatPay(res.data.result);
                        }else if (payType==2){
                            window.location.href = "${apiPath}/view/indent?orderSn="+res.data.result;
                        }
                    }else{
                        alert('后台:支付失败: '+res.data.message)
                    }
                }).catch(function(err){
                    alert('前端:支付失败: '+err.message);
                })
            },
            awakeWechatPay(result){
                if (typeof WeixinJSBridge == "undefined"){
                    if( document.addEventListener ){
                        document.addEventListener('WeixinJSBridgeReady', onBridgeReady,   false);
                    }else if (document.attachEvent){
                        document.attachEvent('WeixinJSBridgeReady', onBridgeReady); 
                        document.attachEvent('onWeixinJSBridgeReady', onBridgeReady);
                    }
                }else{
                    onBridgeReady(result);
                }
            }
         }
        

    })

function onBridgeReady(result){
    WeixinJSBridge.invoke(
        'getBrandWCPayRequest', {
            "appId":result.appId,     //公众号名称，由商户传入     
            "timeStamp":result.timeStamp,         //时间戳，自1970年以来的秒数     
            "nonceStr":result.nonceStr, //随机串     
            "package":result.package,     
            "signType":"MD5",         //微信签名方式：     
            "paySign":result.paySign //微信签名 
        },
        function(res){
            if(res.err_msg == "get_brand_wcpay_request:ok" ){
                console.log("支付成功");
                window.location.href = "${apiPath}/view/indent?orderSn="+result.orderSn;
            } else{
                alert("微信:支付失败"+res.err_msg);
            }
        }
    ); 
}
</script>
