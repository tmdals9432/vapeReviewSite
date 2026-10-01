<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.vape.dao.ProductRepository" %>
<%@ page import="com.vape.dto.Product" %>
<%@ page import="java.util.List" %>

<%
    // 1. 검색어 받기
    String keyword = request.getParameter("keyword");
    
    // 2. 검색어가 없으면 아무것도 안함
    if(keyword == null || keyword.trim().equals("")) {
        return;
    }
    
    // 3. 저장소에서 검색
    List<Product> list = ProductRepository.searchProducts(keyword);
    
    // 4. 결과가 없으면 메시지 표시
    if(list.isEmpty()) {
%>
    <div style="padding: 10px; color: #aaa; text-align: center;">검색 결과가 없습니다.</div>
<%
    } else {
        // 5. 결과가 있으면 리스트 모양(HTML)으로 출력
        for(Product p : list) {
%>
    <a href="<%=request.getContextPath()%>/product/detail.jsp?id=<%=p.getId()%>" class="live-item">
        <div class="live-img">
            <% if(p.getFilename() != null && !p.getFilename().equals("")) { %>
                <img src="<%=request.getContextPath()%>/img/<%= p.getFilename() %>">
            <% } else { %>
                📷
            <% } %>
        </div>
        <div class="live-info">
            <div class="live-name"><%= p.getName() %></div>
            <div class="live-price"><%= p.getPrice() %>원</div>
        </div>
    </a>
<%
        }
    }
%>