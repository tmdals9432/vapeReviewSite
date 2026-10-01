<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String ctx = request.getContextPath();
    String userID = (String) session.getAttribute("userID");
%>
<!DOCTYPE html>
<html>
<head>
<style>
    /* 기본 스타일 */
    body { 
        margin: 0; padding: 0; 
        background-color: #ffffff; 
        color: #333333; 
        font-family: 'Pretendard', 'Malgun Gothic', sans-serif; 
    }
    
    /* 상단 네비게이션 바 */
    .navbar {
        background-color: #ffffff;
        height: 80px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 0 40px;
        border-bottom: 1px solid #e5e5e5;
        position: relative;
        z-index: 100;
    }

    .nav-left { flex: 1; display: flex; justify-content: flex-start; }
    .nav-center { position: absolute; left: 50%; transform: translateX(-50%); text-align: center; }
    .nav-right { flex: 1; display: flex; justify-content: flex-end; align-items: center; gap: 20px; }

    /* 아이콘 & 로고 */
    .menu-icon { font-size: 28px; cursor: pointer; color: #222; transition: 0.2s; }
    .menu-icon:hover { color: #000; opacity: 0.7; }

    .logo { font-size: 32px; font-weight: 900; color: #000000 !important; text-decoration: none; letter-spacing: -1px; }
    
    .nav-right a { color: #444; text-decoration: none; font-weight: 600; font-size: 15px; }
    .nav-right a:hover { color: #000; text-decoration: underline; }
    .nav-right span { color: #888; margin-right: 10px; font-size: 14px; }

    /* 검색바 */
    .nav-search-box { position: relative; margin-right: 20px; width: 300px; }
    .nav-search-form { display: flex; align-items: center; }
    .nav-search-input {
        width: 100%; padding: 10px 15px; border-radius: 4px; border: 1px solid #eee; 
        background: #f7f7f7; color: #333; outline: none; padding-right: 40px; transition: 0.3s;
    }
    .nav-search-input:focus { border-color: #000; background: #fff; }
    .nav-search-btn { position: absolute; right: 10px; background: none; border: none; color: #999; cursor: pointer; font-size: 16px; }

    .search-results {
        display: none; position: absolute; top: 45px; left: 0; width: 100%;
        background-color: #ffffff; border: 1px solid #ddd; border-radius: 4px;
        z-index: 1000; max-height: 400px; overflow-y: auto;
        box-shadow: 0 5px 15px rgba(0,0,0,0.1);
    }
    .live-item { display: flex; align-items: center; padding: 12px; border-bottom: 1px solid #f5f5f5; color: #333; text-decoration: none; transition: 0.2s; }
    .live-item:hover { background-color: #fafafa; color: #000 !important; }
    .live-img { width: 40px; height: 40px; background: #eee; border-radius: 4px; margin-right: 12px; display: flex; justify-content: center; align-items: center; overflow: hidden; border: 1px solid #f0f0f0; }
    .live-img img { width: 100%; height: 100%; object-fit: cover; }
    .live-info { flex: 1; text-align: left; }
    .live-name { font-size: 14px; font-weight: bold; margin-bottom: 4px; color: #222; }
    .live-price { font-size: 13px; color: #888; }

    /* 사이드바 스타일 */
    .sidenav {
        height: 100%; width: 0; position: fixed; z-index: 999; top: 0; left: 0;
        background-color: #ffffff; 
        overflow-x: hidden; transition: 0.4s; padding-top: 60px;
        border-right: 1px solid #eee; 
        box-shadow: 5px 0 20px rgba(0,0,0,0.1);
    }
    .sidenav .closebtn {
        position: absolute; top: 20px; right: 20px; width: 36px; height: 36px;    
        line-height: 36px; text-align: center; font-size: 24px; color: #555;
        background-color: #f0f0f0; border-radius: 50%; text-decoration: none;
        cursor: pointer; z-index: 2000; display: block;  
        transition: background-color 0.2s, color 0.2s;
    }
    .sidenav .closebtn:hover { background-color: #333; color: #fff; }
    
    .sidenav a.menu-link, .dropdown-btn {
        padding: 15px 30px; text-decoration: none; font-size: 16px; 
        color: #444; display: block; transition: 0.2s; 
        border: none; background: none; width: 100%;
        text-align: left; cursor: pointer; outline: none; font-weight: 600;
    }
    .sidenav a.menu-link:hover, .dropdown-btn:hover { color: #000; background-color: #f9f9f9; padding-left: 35px; }
    
    .dropdown-container { display: none; background-color: #fcfcfc; padding-left: 20px; padding-bottom: 10px; border-bottom: 1px solid #f0f0f0; }
    .dropdown-container a { font-size: 14px; padding: 12px 30px; color: #666; display: block; text-decoration: none; }
    .dropdown-container a:hover { color: #000; background-color: #eee; border-radius: 4px; }
    .menu-label { display: block; padding: 15px 30px 5px 30px; color: #aaa; font-size: 11px; font-weight: bold; cursor: default; letter-spacing: 1px;}
    .menu-item-wrap:hover .dropdown-container { display: block; }
    
    .user-info { color: #333; text-align: center; padding-bottom: 30px; margin-bottom: 10px; border-bottom: 1px solid #f0f0f0; }
    .user-icon { font-size: 40px; margin-bottom: 10px; display: block; }
    
    .bottom-auth { position: absolute; bottom: 30px; width: 100%; text-align: center; }
    .btn-auth { border: 1px solid #333; color: #333 !important; padding: 12px 30px !important; text-decoration: none; font-weight: bold; font-size: 14px !important; display: inline-block !important; transition: 0.3s; }
    .btn-auth:hover { background-color: #000; color: white !important; }

    /* ★★★ [추가됨] 우측 하단 1:1 문의 플로팅 버튼 ★★★ */
    .fab-container {
        position: fixed;
        bottom: 30px;
        right: 30px;
        z-index: 9999;
    }

    /* 동그란 버튼 */
    .fab-btn {
        width: 60px; height: 60px;
        background-color: #000; /* 검은색 */
        color: #fff;
        border-radius: 50%;
        display: flex; justify-content: center; align-items: center;
        font-size: 24px;
        cursor: pointer;
        box-shadow: 0 4px 15px rgba(0,0,0,0.2);
        transition: 0.3s;
    }
    .fab-btn:hover { transform: scale(1.1); background-color: #333; }

    /* 문의 팝업창 */
    .inquiry-box {
        display: none; /* 평소엔 숨김 */
        position: absolute;
        bottom: 80px;
        right: 0;
        width: 320px;
        background-color: #fff;
        border-radius: 12px;
        box-shadow: 0 5px 25px rgba(0,0,0,0.15);
        border: 1px solid #eee;
        padding: 20px;
        box-sizing: border-box;
        animation: slideUp 0.3s;
    }

    @keyframes slideUp {
        from { opacity: 0; transform: translateY(20px); }
        to { opacity: 1; transform: translateY(0); }
    }

    .iq-header { font-size: 18px; font-weight: bold; margin-bottom: 15px; display: flex; justify-content: space-between; align-items: center; }
    .iq-close { font-size: 24px; cursor: pointer; color: #999; }
    .iq-close:hover { color: #000; }

    .iq-input { width: 100%; padding: 10px; margin-bottom: 10px; border: 1px solid #ddd; border-radius: 4px; box-sizing: border-box; font-family: 'Pretendard'; }
    .iq-textarea { width: 100%; height: 100px; padding: 10px; margin-bottom: 10px; border: 1px solid #ddd; border-radius: 4px; resize: none; box-sizing: border-box; font-family: 'Pretendard'; }
    .iq-btn { width: 100%; background-color: #000; color: white; padding: 12px; border: none; border-radius: 4px; font-weight: bold; cursor: pointer; }
    .iq-btn:hover { background-color: #333; }

</style>

<script>
    function openNav() { document.getElementById("mySidenav").style.width = "300px"; }
    function closeNav() { document.getElementById("mySidenav").style.width = "0"; }

    function liveSearch(input) {
        var keyword = input.value;
        var resultBox = document.getElementById("liveResults");
        if(keyword.trim() == "") { resultBox.style.display = "none"; return; }
        var xhr = new XMLHttpRequest();
        xhr.onreadystatechange = function() {
            if (xhr.readyState == 4 && xhr.status == 200) {
                resultBox.innerHTML = xhr.responseText;
                resultBox.style.display = "block";
            }
        };
        xhr.open("GET", "<%=ctx%>/search_proc.jsp?keyword=" + encodeURIComponent(keyword), true);
        xhr.send();
    }

    /* ★★★ 1:1 문의 기능 ★★★ */
    function toggleInquiry() {
        var box = document.getElementById("inquiryBox");
        var userID = "<%= userID %>"; // JSP 변수 가져오기

        if(userID == "null") {
            alert("로그인 후 이용 가능합니다! 😅");
            location.href = "<%=ctx%>/member/login.jsp";
            return;
        }

        if(box.style.display === "block") {
            box.style.display = "none";
        } else {
            box.style.display = "block";
        }
    }

    function sendInquiry() {
        var title = document.getElementById("iqTitle").value;
        var content = document.getElementById("iqContent").value;

        if(title.trim() == "" || content.trim() == "") {
            alert("제목과 내용을 모두 입력해주세요.");
            return;
        }

        // 실제 전송 로직은 없으므로 알림만 띄움
        alert("관리자에게 문의가 접수되었습니다. \n빠른 시일 내에 답변 드리겠습니다! 🚀");
        document.getElementById("iqTitle").value = "";
        document.getElementById("iqContent").value = "";
        toggleInquiry(); // 창 닫기
    }
</script>
</head>
<body>

<div class="navbar">
    <div class="nav-left"><span class="menu-icon" onclick="openNav()">&#9776;</span></div>
    <div class="nav-center"><a href="<%=ctx%>/index.jsp" class="logo">VAPE REVIEW</a></div>
    <div class="nav-right">
        <div class="nav-search-box">
            <form action="<%=ctx%>/product/list.jsp" method="get" class="nav-search-form">
                <input type="text" name="keyword" class="nav-search-input" placeholder="제품 검색" onkeyup="liveSearch(this)" autocomplete="off">
                <button type="submit" class="nav-search-btn">🔍</button>
            </form>
            <div id="liveResults" class="search-results"></div>
        </div>
        <% if(userID == null) { %>
            <a href="<%=ctx%>/member/login.jsp">로그인</a>
            <a href="<%=ctx%>/member/join.jsp">회원가입</a>
        <% } else { %>
            <span><%= userID %>님</span>
            <a href="<%=ctx%>/member/logoutAction.jsp">로그아웃</a>
        <% } %>
    </div>
</div>

<div id="mySidenav" class="sidenav">
    <a href="javascript:void(0)" class="closebtn" onclick="closeNav()">×</a>
    <div class="user-info">
        <span class="user-icon">👤</span>
        <% if(userID == null) { %> <p style="font-weight:bold; margin-top:10px;">로그인 해주세요</p>
        <% } else { %> <p><strong><%= userID %></strong>님<br>환영합니다!</p> <% } %>
    </div>
    <div class="menu-item-wrap">
        <div class="dropdown-btn">궐련형 ▾</div> 
        <div class="dropdown-container">
            <a href="<%=ctx%>/product/list.jsp?type=heat&sub=device">궐련형 기기</a>
            <a href="<%=ctx%>/product/list.jsp?type=heat&sub=stick">전용 스틱</a>
        </div>
    </div>
    <div class="menu-item-wrap">
        <div class="dropdown-btn">액상형 ▾</div>
        <div class="dropdown-container">
            <span class="menu-label">[ 기기 ]</span>
            <a href="<%=ctx%>/product/list.jsp?type=liquid&sub=mtl">입호흡 기기 (MTL)</a>
            <a href="<%=ctx%>/product/list.jsp?type=liquid&sub=dtl">폐호흡 기기 (DTL)</a>
            <span class="menu-label" style="padding-top: 15px;">[ 액상 ]</span>
            <a href="<%=ctx%>/product/list.jsp?type=juice&sub=mtl">입호흡 액상</a>
            <a href="<%=ctx%>/product/list.jsp?type=juice&sub=dtl">폐호흡 액상</a>
        </div>
    </div>
    <a href="<%=ctx%>/product/list.jsp?type=disposable" class="menu-link">일회용 전자담배</a>
    <div class="bottom-auth">
        <% if(userID == null) { %> <a href="<%=ctx%>/member/login.jsp" class="btn-auth">LOGIN / JOIN</a>
        <% } else { %> <a href="<%=ctx%>/member/logoutAction.jsp" class="btn-auth">LOGOUT</a> <% } %>
    </div>
</div>

<div class="fab-container">
    <div id="inquiryBox" class="inquiry-box">
        <div class="iq-header">
            1:1 문의하기
            <span class="iq-close" onclick="toggleInquiry()">×</span>
        </div>
        <input type="text" id="iqTitle" class="iq-input" placeholder="제목을 입력하세요">
        <textarea id="iqContent" class="iq-textarea" placeholder="문의하실 내용을 남겨주세요."></textarea>
        <button type="button" class="iq-btn" onclick="sendInquiry()">문의 접수</button>
    </div>

    <div class="fab-btn" onclick="toggleInquiry()">
        📞
    </div>
</div>

</body>
</html>