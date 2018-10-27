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
    <script type="text/javascript" src="${staticPath}/js/vue-cookies.js"></script>
    <script type="text/javascript" src="${staticPath}/js/axios.js"></script>
    <script type="text/javascript" src="${staticPath}/js/server.js"></script>
    <script type="text/javascript" src="${staticPath}/js/common.js"></script>
    <script type="text/javascript" src="${staticPath}/js/vue-lazyload.js"></script>
    <script type="text/javascript" src="${staticPath}/js/date.js"></script>
    <style type="text/css">
    	  .detail-constent{
    	  	  width:100%;
    	   }
    	   .detail-constent-img{
    	   	  width:100%;
    	   	  height:auto;
    	   	  background-color:#FFFFFF;
    	   	  text-align: center;
    	   	  margin-bottom:0.5rem;
    	   }
    	    .detail-constent-img img{
    	    	width: 100%;
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
    	   	    color: dimgray;   
    	   }
    	    .constent-title-left p{
    	    	color: #CCCCCC;
    	    	font-size:1rem ;
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
    	    .constent-price-sale i:nth-child(2){
    	    	width:1rem;
    	    	height:1rem ;
    	    	margin-left:1rem;
                padding:0.2rem 0.4rem;
    	    	background-color:#ccc;
    	    	border-radius:0.25rem;
    	    	color:#333;
    	    	line-height:1rem;
    	    	font-size: 1rem;	
    	    }
    	    .constent-price i{
    	    	font-size:0.9rem;
    	    }
            .constent-underline{
            	width:100%;
            	height:1px;
            	background-color:#DFDFDF;
            }
            .constent-indent p{
            	font-size:0.8rem;
            	margin-top:0.5rem;
            	color:#808080;
            	text-align:left;
            }
            .constent-slices{
            	margin-top:2rem;
            	width:100%;
            	position:relative;
            	text-align: center;
            }
            .constent-slices img{
                width:10rem;
            }
            .constent-slices p{
            	width: 100%;
            	position: absolute;
            	font-size:1.8rem;
            	color:white;
            	bottom:0.5rem;
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
			 	 <img v-lazy="list.detailList[0].goodsImage"/>
			 </div>
			 <div class="detail-constent-title">
			 	  <div class="constent-title-left">
			 	  	   <h3  align="left">{{list.detailList[0].goodsName}}</h3>
			 	  	   <p align="left">{{list.detailList[0].goodsAbbreviation}}</p>
			 	  
			 	    <div class="">
			                <div class="constent-price-sale">
			                    <span><i>￥</i>{{list.detailList[0].goodsPrice}}</span><i>已购</i>
			                   
			                    <div class="constent-price-logo fr">
			                    	<img src="${staticPath}/images/index/热卖icon@3x.png" v-show="list.detailList[0].isHot"/>
			                    </div>
			                </div>
			 	     </div>
			 	     <div class="constent-underline"></div>
			 	     <div class="constent-indent">
			 	     	 <p>订单编号：{{list.orderSn}}</p>
			 	     	 <p>订单时间：{{format(list.orderTime)}}</p>
			 	     	<p>支付方式：
                            <span v-if="list.payType==1">微信支付</span>
                            <span v-else>余额支付</span>
                        </p>
			 	     </div>
			 	     <div class="constent-slices">
			 	     	<img src="${staticPath}/images/取货码@3x.png"/>
			 	     	<p>{{list.pickupCode}}</p>
			 	     </div>
			 	  </div>
			 </div>
		</div>
	</div>
</body>
</html>

<script>
    Vue.use(VueLazyload, {
      preLoad: 1.3,
      error: '${staticPath}/images/index/商品详情主图占位图@3x.png',
      loading: '${staticPath}/images/index/商品详情主图占位图@3x.png',
      attempt: 3
    })

	var app = new Vue({
        el: '#app',
        data(){
            return{
                   list:{}
            }
        },
         mounted(){
         	this.pullgoodsDetail();
         },
         methods:{
            format(time) {
                return new Date(time).Format('yyyy年MM月dd日 hh:mm:ss');
            },
         	pullgoodsDetail(){
         		var _this = this;
         		axios.get('${apiPath}/order/detail',{
                    params:{
                      orderSn:${orderSn}
                    }
                }).then(function(res){            
                    if (res.data.code==1){
                        console.log(res.data);
                        _this.list=res.data.result
                        console.log(_this.list);
                    }else{
                    	alert ('获取商品详情失败: '+res.data.message);
                    }
                })
                .catch(function(err){
                    alert('获取商品详情失败: '+err.message);
                })
         	}
         }

    })
</script>