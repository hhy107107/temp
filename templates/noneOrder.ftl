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
    <style>
    	html,body{
    		background-color:rgb(244,244,244);
    		
    	}
    	 .order{
    	 	width:100%;
    	 	/*background-color:rgb(244,244,244);*/
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
    	 .default{
    	 	margin:5rem auto 0rem;
    	 	text-align: center;
    	 }
    	 .default p{
    	 	margin:1rem auto;
    	 	color: #696969;
    	 	
    	 }

    </style>
</head>
<body>
	    <div id="app">
			   <div class="order">
		   	     <div class="order-goods">
		   	     	<span class="active">
		   	     		待取货
		   	     	</span>
		   	     	<span class="">
		   	     		已完成
		   	     	</span>
		   	     </div>
		     </div>
		     <div  class="default">
		     	<img src="${staticPath}/images/default.png"/>
		     	<p>亲，暂无相关订单哦~</p>
		     </div>
		   
		   
		   
		 </div>  
</body>
</html>

<script>
	var app = new Vue({
        el: '#app',
        data(){
            return{
            	msg:"helloworld!",
            }
        }
    })
</script>