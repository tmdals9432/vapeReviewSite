package com.vape.dto;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.UUID;

public class Review {
    
    private String uid;       // 리뷰 고유 번호 (삭제/수정할 때 필요)
    private String productId; // 어떤 제품의 리뷰인지
    private String writer;    // 작성자
    private String password;  // 비밀번호
    private String content;   // 내용
    private int star;         // 별점 (1~5)
    private String date;      // 작성일

    // 생성자 (Repository에서 객체 만들 때 사용)
    public Review(String productId, String writer, String password, String content, int star) {
        this.uid = UUID.randomUUID().toString(); // 랜덤한 고유 ID 생성
        this.productId = productId;
        this.writer = writer;
        this.password = password;
        this.content = content;
        this.star = star;
        // 기본값은 오늘 날짜 (나중에 setDate로 덮어씌움)
        this.date = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
    }

    // ★★★ 이 부분이 없어서 오류가 났을 겁니다! (Setter) ★★★
    public void setDate(String date) {
        this.date = date;
    }
    public void setContent(String content) {
        this.content = content;
    }
    public void setStar(int star) {
        this.star = star;
    }

    // Getters (데이터 가져올 때 필요)
    public String getUid() { return uid; }
    public String getProductId() { return productId; }
    public String getWriter() { return writer; }
    public String getPassword() { return password; }
    public String getContent() { return content; }
    public int getStar() { return star; }
    public String getDate() { return date; }
}