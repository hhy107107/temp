<!DOCTYPE html>
<html>
<head>
	<title>咖啡机移动端</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" href="${staticPath}/css/adapter.css">
    <link rel="stylesheet" href="${staticPath}/css/weui.css">
    <script type="text/javascript" src="${staticPath}/js/vue.js"></script>
    <script type="text/javascript" src="${staticPath}/js/weui.js"></script>
    <script type="text/javascript" src="${staticPath}/js/vue-lazyload.js"></script>
    <script type="text/javascript" src="${staticPath}/js/vue-cookies.js"></script>
    <script type="text/javascript" src="${staticPath}/js/axios.js"></script>
    <script type="text/javascript" src="${staticPath}/js/server.js"></script>
    <script type="text/javascript" src="${staticPath}/js/date.js"></script>
    <style>
    	body{
    		background-color:rgb(244,244,244);
    	}
         ul li{
         	list-style: none;
         }
         a {
         	text-decoration: none;
         	cursor: pointer;
         }
    	 .order{
    	 	width:100%;
    	
    	 }
    	 .order-goods{
    	 	width:90%;
    	 	margin:0 auto;
    	 }
    	 .order-goods>span{
    	 	width:5rem;
    	 	height:2rem ;
    	 	text-align: center;
    	 	line-height:2rem ;
    	 	display:inline-block;
    	 	margin:1rem 0.5rem;
    	 	font-size:1.1rem;
            font-weight:500;
    	 }
    	 .active{
    	 	color: white;
    	 	background-color:rgb(51,51,51);
    	 	border-radius:1.5rem;
    	 }

    	 .order-constent{
    	 	width:90%;
    	 	margin:0 auto;
    	 }
    	 .order-constent li{
    	 	background-color: #FFFFFF;
    	 	margin-bottom:1rem;
    	 	border-radius:0.5rem;
    	 }
    	 .constent-title p{
    	 	display:inline-block;
    	 	font-size: 0.9rem;
    	 	color:rgb(51,51,51);
    	 	margin:0.5rem 1rem;
        width: 60%;
        text-overflow : ellipsis;
        white-space:nowrap;
        overflow:hidden;
    	 }

         .constent-title span{
         	display:inline-block;
         	float:right;
         	font-size:0.8rem ;
         	margin:0.5rem 1rem;
            color:rgb(160,90,40);
         }
         .constent-goods{
         	width:100%;
         	overflow:hidden;
         }
         .constent-goods-img{
         	 margin:1rem 0.5rem 1rem 1rem;
          	 width:26%;
          }
          .constent-goods-img img{
          	width: 100%;
          	height: 100%;
            max-height:5.5rem;
          	border-radius:0.3rem;
          }
          .fl{
         	float: left;
          }
          .constent-goods-details{
          	width:62%;
          	color: #000000;
          }
          .constent-goods-details h4{
          	padding:1rem 0;
          	font-size:1rem;
          	font-weight: 100;
          	
          }
         
           .constent-goods-price{
           	  font-size:1.2rem;
           }
           .constent-goods-price i{
           	  font-size:0.9rem ;
           }
           .constent-time{
    	 	display: inline-block;
    	 	height:1.8rem;
    	  }
           .constent-time span{
         	display:inline-block;
         	float:right;
         	margin-right:1rem;
         	font-size:0.8rem;
    	 	color:#C8C8CD;
    	 	line-height: 1.8rem;
          }
           .constent-dashed{
         	  width:100%;
         	  height:1px;
         	  background-color:#ccc;
         }
         .pickup-code{
         	text-align: center;
         	color: rgb(160,90,40);
         	margin:0.5rem auto;
         }
         
          .default{
    	 	margin:5rem auto 0rem;
    	 	text-align: center;
    	 }
    	 .default p{
    	 	margin:1rem auto;
    	 	color: #696969;
    	 	
    	 }
    	 .constent-item{
    	 	overflow: hidden;
    	 }
    </style>
</head>
<body>
	
	<div id="app">
		   <div class="order">
		   	     <div class="order-goods">
		   	     	<span  v-bind:class="{ active:flag}" v-on:click="getChange(true)">
		   	     		待取货
		   	     	</span>
		   	     	<span v-bind:class="{ active:!flag}" v-on:click="getChange(false)">
		   	     		已完成
		   	     	</span>
		   	     </div>
		   </div>
		   
		
				<div class="order-constent">
					<ul v-show='flag'>
						<li v-for="(item,key) in list1">
							<a :href="jumpItem(item.orderSn)">
							<div class="constent-title">
								<p>订单编号：{{item.orderSn}}</p>
								<span>
								    待取货
								</span>
							</div>
							
							<div class="constent-goods">
							
									<div class="constent-goods-img fl">
										<img  v-lazy="item.goodsImage">
									</div>
					
									<div class="constent-goods-details fr">
										<h4>{{item.goodsName }}</h4>
										
									<div class="constent-item">	
										<div class="constent-goods-price fl">
											<span><i>￥</i>{{item.orderPrice}}</span>
										</div>
										<div class="constent-time fr">
											<span>
												{{format(item.payTime)}}
											</span>
										</div>
					                   </div>
									</div>
								
							</div>
							<div class="constent-dashed"></div>
							<div class="pickup-code">
								<p>取货码:{{item.pickupCode}}</p>
							</div>
							</a>
						</li>
				    </ul>
			        
			        <ul v-show='!flag'>
						<li v-for="(item,key) in list2">
							<div class="constent-title">
								<p>订单编号：{{item.orderSn}}</p>
								<span>
								    订单已完成
								</span>
							</div>
							
							<div class="constent-goods">
								<div class="constent-goods-img fl">
									<img   v-lazy="item.goodsImage">
								</div>
				
								<div class="constent-goods-details fr">
									<h4>{{item.goodsName }}</h4>
									<div class="constent-goods-price fl">
										<span><i>￥</i>{{item.orderPrice}}</span>
									</div>
									<div class="constent-time fr">
										<span>
												   	{{format(item.orderTime)}}
										</span>
									</div>
				
								</div>
							</div>
						</li>
				    </ul>
				    
				</div>
	
	          <div  class="default" v-show="(flag&&list1.length==0)||(!flag&&list2.length==0)">
		     	<img src="${staticPath}/images/default.png"/>
		     	<p>亲，暂无相关订单哦~</p>
		     </div>

	</div>
	
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
	            	flag:true,
	            	list1:[],
	            	list2:[]
	            }
	       },        
	         mounted(){
	         	this.pullgoodsDetail();
		         },
           methods:{
            format(time) {
                return new Date(time).Format('yyyy-MM-dd hh:mm:ss');
            }, 
         	pullgoodsDetail(){
         		var _this = this;
         		axios.get('${apiPath}/order/list',{
                    params:{
                      type:1,
                      pageNo:1,
                      pageSize:100
                      
                    }
                }).then(function(res){            
                    if (res.data.code==1){
                        _this.list1=res.data.result.list
                    }else{
                    	alert ('获取商品详情失败: '+res.data.message);
                    }
                }).catch(function(err){
                    alert('获取商品详情失败: '+err.message);
                })
                axios.get('${apiPath}/order/list',{
                    params:{
                      type:2,
                      pageNo:1,
                      pageSize:100
                    }
                }).then(function(res){            
                    if (res.data.code==1){
                        _this.list2=res.data.result.list
                    }else{
                    	alert ('获取商品详情失败: '+res.data.message);
                    }
                }).catch(function(err){
                    alert('获取商品详情失败: '+err.message);
                })
         	},
					getChange(key){
						  this.flag=key;
				     },
				     jumpItem(orderSn){
                         return "${apiPath}/view/indent?orderSn="+orderSn;
                    }
           }
	    })
	</script>
</body>
</html>
