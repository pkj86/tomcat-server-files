/**
 *  jquery.js 라이브러리 기능을 일부 구현해본다
 */
function mlec(val)
{	
	if(typeof (val) == "function")
	{
		window.onload = val;
		return;
	}
	
	// val 값을 파싱하여 적절한 작업을 처리
	var ch = val.charAt(0);
	var elements;
	switch(ch)
	{
	case "#":
		elements = document.querySelector(val);
		break;
	case "<":	//$("<div>");
		elements = document.createElement(val.substring(1, val.length-1));
		break;
	case "@":
		elements = document.querySelectorAll("#" + val.substring(1, val.length));
		break;
	default:
		elements = document.querySelectorAll(val);
		break;
	}
	// html 함수 추가하기 : innerHTML 대체
	elements.html = function(msg){
		// elements가 배열인 경우
		if(this.length)
		{			
			if(msg)
			{
				// 0번 요소의 innerHTML만 변경
				//this[0].innerHTML = msg;
				// 모든 요소 변경
				for(var i = 0 ; i < this.length ; i++)
				{
					this[i].innerHTML = msg;
				}
				return this;
			}
			return this[0].innerHTML;
		}
		else
		{	// elements가 하나인 경우
			if(msg == null)
			{ return this.innerHTML; }
			else
			{ 
				this.innerHTML = msg;
			}
			return this;
		}
	};
	
	// text 함수 추가하기 : innerText 대체
	elements.text = function(msg){
		// elements가 배열인 경우
		if(this.length)
		{
			if(msg)
			{
				// 0번 요소의 innerText만 변경
				//this[0].innerText = msg;
				// 모든 요소 변경
				for(var i = 0 ; i < this.length ; i++)
				{
					this[i].innerText = msg;
				}
				return this;
			}
			return this[0].innerText;
		}
		else
		{	// elements가 하나인 경우
			if(msg == null)
			{ return this.innerText; }
			else
			{ 
				this.innerText = msg;
			}
			return this;
		}
	};
	
	// val 함수 추가하기 : value 대체
	elements.val = function(val){
		// elements가 배열인 경우
		if(this.length)
		{
			if(val)
			{
				// 0번 요소의 value만 변경
				this[0].value = val;
				// 모든 요소 변경
				/*for(var i = 0 ; i < this.length ; i++)
				{
					this[i].value = val;
				}*/
				return this;
			}
			return this[0].value;
		}
		else
		{	// elements가 하나인 경우
			if(val == null)
			{ return this.value; }
			else
			{ 
				this.value = val;
			}
			return this;
		}
	};
	
	// attr 함수 추가하기 : attribute 
	elements.attr = function (key, value) {
		// elements 가 배열인 경우
		if (this.length) {
			// 여러개의 속성값을 한번에 넘겨받았을 경우 처리
			if (typeof (key) == "object") {
				for (var k in key) {
					this[0].setAttribute(k, key[k]);
				}
				return this;
			}
				
			if (value) {
				this[0].setAttribute(key, value);
				return this;
			}
			return this[0].getAttribute(key);
		} 
		// elements 가 하나인 경우(# 접근)
		else {
			// 여러개의 속성값을 한번에 넘겨받았을 경우 처리
			if (typeof (key) == "object") {
				for (var k in key) {
					this.setAttribute(k, key[k]);
				}
				return this;
			}
			if (value) {
				this.setAttribute(key, value);
				return this;
			} 
			return this.getAttribute(key);
		}
	};
	
	// CSS함수 추가하기 : style
	elements.CSS = function(key, value){
		if(this.length)
		{
			// 여러개의 속성값을 한번에 넘겨받았을 경우 처리
			if(typeof(key) == "object")
			{				
				for(var ke in key)
				{
					for(var i = 0 ; i < this.length ; i++)
					{
						this[i].style[ke] = key[ke];						
					}
				}
				return this;
			}
			if(value)
			{			
				for(var i = 0 ; i < this.length ; i++)
				{
					this[i].style[ke] = key[ke];						
				}
				return this;
			}
			return this[0].style[key];
		}
		else
		{
			if(typeof(key) == "object")
			{				
				for(var ke in key)
				{
					this[0].style[ke] = key[ke];
				}
				return this;
			}
			if(value)
			{			
				return this.style[key] = value;						
			}
			return this[0].style[key];
		}
	};
	
	// appendChild
	elements.append = function(ele){
		if(this.length)
		{
			for(var i = 0 ; i < this.length ; i++)
			{
				this[i].appendChild(ele);						
			}
		}
		else
		{ this.appendChild(ele); }
		return this;		
	}
	
	// addEventListener
	elements.on = function(event, func){
		if(this.length)
		{
			for(var i = 0 ; i < this.length ; i++)
			{
				this[i].addEventListener(event, func);
			}
		}
		else
		{ this.addEventListener(event, func); }
		return this;		
	}
	
	// addEventListener.click
	elements.click = function(func){
		/*if(this.length)
		{
			for(var i = 0 ; i < this.length ; i++)
			{
				this[i].addEventListener("click", func);
			}
		}
		else
		{ this.addEventListener("click", func); }
		return this;*/
		
		this.on("click", func);
	}
	
	return elements;
}

var $ = mlec;
// ajax 추가..
$.ajax = function(options){
	/*
	 * options : ajax에서 필요로 하는 값들
	 * options.type : get or post 방식 지정
	 * options.dataType : json, xml....응답데이터에 대한 처리 지정
	 * options.url : 호출할 서버 페이지
	 * options.data : 서버페이지에서 사용할 파라메터 객체
	 * options.success : 응답결과 처리할 콜백함수
	 */
	// ajax 통신객체 생성
	var xhr = new XMLHttpRequest();
	// 결과처리를 위한 콜백함수 등록
	xhr.onreadystatechange = function (){
		// 결과 처리
		if(xhr.readyState == 4)
		{
			// 모든 응답이 서버에서 왔을때
			if(xhr.status == 200)
			{
				var result = xhr.responseText;
				switch(options.dataType)
				{
				case "json":
					result = JSON.parse(xhr.responseText);
					break;
				case "xml":
					result = xhr.responseXML;
					break;
				}
				options.success(result);
			}
		}
	};
	// 사용자 요청 메소드 설정
	var method = options.type ? options.type : "GET" ;
	if(method != "GET" && method != "POST"){ method = "GET"; }
	// 사용자 호출 url 처리
	// GET 방식의 경우 options.data를 url에 추가
	// POST 방식의 경우 options.data를 send함수에 추가
	// 객체가 가지고 있느 데이터를 파라미터형태의 문자열로 변경
	var params = "";
	// 사용자가 데이터를 options에 추가했는지 여부확인
	if(options.data)
	{
		for(var key in options.data)	// {id: "aaa", pass: 1234}
		{
			if(params == ""){
				params += key + "=" + options.data[key];				
			}else{
				params += "&" + key + "=" + options.data[key];
			}
		}
	}
	var url = options.url;
	if(method == "GET" && params != "")
	{
		url += "?" + params;
	}
	
	xhr.open(method, url, true);
	// POST
	if(method == "POST"){
		xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded"); }
	xhr.send(method == "POST" ? params : null);
};