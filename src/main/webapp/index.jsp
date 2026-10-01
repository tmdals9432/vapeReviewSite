<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.vape.dao.ProductRepository" %>
<%@ page import="com.vape.dao.ReviewRepository" %>
<%@ page import="com.vape.dto.Product" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Collections" %>
<%@ page import="java.util.Comparator" %>
<%
    // 1. 전체 상품 가져오기 (액상, 기기, 일회용 전부 다 포함됨)
    List<Product> allProducts = new ArrayList<>(ProductRepository.getAllProducts()); 
    
    // 2. ★ 중요: 리뷰 개수가 많은 순서대로 섞어서 정렬하기 ★
    // 이걸 해야 기기랑 액상이랑 경쟁해서 진짜 인기 있는 게 1등이 됩니다.
    Collections.sort(allProducts, new Comparator<Product>() {
        @Override
        public int compare(Product p1, Product p2) {
            int count1 = ReviewRepository.getReviewCount(p1.getId());
            int count2 = ReviewRepository.getReviewCount(p2.getId());
            // 내림차순 정렬 (리뷰 많은 게 앞으로)
            return Integer.compare(count2, count1);
        }
    });

    // 3. 정렬된 리스트에서 TOP 3만 자르기
    List<Product> top3Products = new ArrayList<>();
    if(allProducts.size() >= 3) {
        top3Products = allProducts.subList(0, 3);
    } else {
        top3Products = allProducts;
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>VAPE REVIEW - 메인</title>
<style>
    /* 화이트 & 블랙 스타일 */
    body { 
        background-color: #ffffff; 
        color: #333; 
        font-family: 'Pretendard', 'Malgun Gothic', sans-serif; 
        margin: 0; 
    }

    /* 메인 배너 섹션 */
    .hero-section {
        text-align: center;
        padding: 80px 20px;
        background-color: #fff;
        background: linear-gradient(180deg, #ffffff 0%, #f9f9f9 100%);
    }

    .hero-title {
        font-size: 42px;
        font-weight: 900;
        margin-bottom: 15px;
        color: #000;
        letter-spacing: -1px;
    }
    .hero-subtitle {
        color: #666;
        font-size: 18px;
        margin-bottom: 60px;
        font-weight: 500;
    }

    /* TOP 3 그리드 */
    .top-grid {
        display: flex;
        justify-content: center;
        gap: 30px;
        flex-wrap: wrap;
        max-width: 1200px;
        margin: 0 auto;
    }

    /* 카드 스타일 */
    .best-card {
        background-color: #fff;
        width: 320px;
        border-radius: 12px;
        overflow: hidden;
        text-decoration: none;
        color: #333;
        transition: 0.3s;
        border: 1px solid #eee;
        position: relative;
        box-shadow: 0 5px 15px rgba(0,0,0,0.05);
    }

    .best-card:hover {
        transform: translateY(-10px);
        box-shadow: 0 15px 30px rgba(0, 0, 0, 0.1); 
        border-color: #000;
    }

    /* 랭킹 뱃지 */
    .rank-badge {
        position: absolute;
        top: 20px;
        left: 20px;
        background-color: #000;
        color: #fff;
        width: 45px; height: 45px;
        border-radius: 50%;
        font-weight: 900;
        font-size: 22px;
        display: flex; justify-content: center; align-items: center;
        box-shadow: 0 4px 8px rgba(0,0,0,0.2);
        z-index: 10;
        font-family: 'Pretendard', sans-serif;
    }

    .card-img {
        height: 280px;
        background-color: #f8f8f8;
        display: flex; justify-content: center; align-items: center;
        font-size: 60px; color: #ccc;
        border-bottom: 1px solid #f0f0f0;
        overflow: hidden;
    }
    .card-img img { 
        width: 100%; height: 100%; object-fit: contain; 
        padding: 30px; box-sizing: border-box; 
        transition: 0.3s;
    }
    .best-card:hover .card-img img { transform: scale(1.05); }

    .card-info { padding: 25px; text-align: left; }
    
    .card-title { 
        font-size: 20px; font-weight: bold; display: block; margin-bottom: 8px; 
        color: #000; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;
    }
    
    .card-desc { 
        color: #777; font-size: 14px; margin-bottom: 20px; height: 42px; overflow: hidden; line-height: 1.5;
        display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical;
    }
    
    .rating-area { 
        border-top: 1px solid #f0f0f0; 
        padding-top: 15px; 
        display: flex; justify-content: space-between; align-items: center;
    }
    .score { color: #f5a623; font-weight: bold; font-size: 16px; }

    .view-btn {
        color: #000; font-weight: 800; font-size: 13px;
        transition: 0.2s;
    }
    .best-card:hover .view-btn { text-decoration: underline; }

</style>
</head>
<body>
    
    <jsp:include page="header.jsp" />

    <div class="hero-section">
        <h1 class="hero-title">WEEKLY BEST TOP 3</h1>
        <p class="hero-subtitle">전체 카테고리 중 가장 리뷰가 많은 제품들입니다.</p>
        
        <div class="top-grid">
            <% 
               int rank = 1;
               for(Product p : top3Products) { 
                   double avg = ReviewRepository.getAverageRating(p.getId());
                   int count = ReviewRepository.getReviewCount(p.getId());
                   String avgStr = String.format("%.1f", avg);
            %>
                <a href="product/detail.jsp?id=<%=p.getId()%>" class="best-card">
                    <div class="rank-badge"><%= rank++ %></div>
                    
                    <div class="card-img">
                        <% if(p.getFilename() != null && !p.getFilename().equals("")) { %>
                             <img src="img/<%= p.getFilename() %>" alt="<%= p.getName() %>">
                        <% } else { %>
                             📷
                        <% } %>
                    </div>
                    
                    <div class="card-info">
                        <span class="card-title"><%= p.getName() %></span>
                        <div class="card-desc"><%= p.getDesc() %></div>
                        
                        <div class="rating-area">
                            <% if(count == 0) { %>
                                <span style="color:#999; font-size:13px;">첫 리뷰를 기다려요</span>
                            <% } else { %>
                                <div>
                                    <span class="score">★ <%= avgStr %></span>
                                    <span style="color:#999; font-size:13px; margin-left:5px;">(<%= count %>)</span>
                                </div>
                            <% } %>
                            <span class="view-btn">VIEW ></span>
                        </div>
                    </div>
                </a>
            <% } %>
        </div>
    </div>

</body>
</html>