package com.vape.dao;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import com.vape.dto.Review;

public class ReviewRepository {
    
    private static List<Review> reviews = new ArrayList<>();

    // ★★★ 자동 리뷰 생성기 ★★★
    static {
        Random random = new Random();
        
        // 1. 닉네임 재료
        String[] nickAdj = {"베이핑", "전담", "액상", "금연", "모드기기", "헤비", "깔끔", "친절한", "구름", "맛표현", "연기", "쿨링"};
        String[] nickNoun = {"고수", "입문자", "매니아", "유저", "러버", "아재", "누나", "형", "박사", "감별사", "요정", "장인"};

        // 2. 리뷰 내용 재료
        String[] contents = {
            "배송이 정말 빠르네요! 하루만에 도착했습니다. 포장도 꼼꼼해요.",
            "인생 기기/액상 찾았습니다. 맛 표현이 아주 좋습니다.",
            "디자인이 실물이 훨씬 예쁩니다. 마음에 쏙 들어요.",
            "가성비 최고입니다. 이 가격에 이 퀄리티라니!",
            "지인 추천으로 샀는데 후회 없습니다. 강추합니다.",
            "생각보다 타격감이 세서 놀랐습니다. 아주 만족해요.",
            "누수가 조금 걱정됐는데, 다행히 양품이 왔네요.",
            "재구매 의사 200% 입니다. 사장님 번창하세요!",
            "무화량이 장난 아니네요. 연기 뿜는 맛이 납니다.",
            "처음 써보는데 사용법도 쉽고 관리하기도 편해요.",
            "기대했던 것보다 훨씬 괜찮네요. 잘 쓰겠습니다.",
            "색감이 미쳤습니다. 너무 영롱하네요 ㅠㅠ",
            "맛이 깔끔하고 질리지 않아요. 데일리로 딱입니다.",
            "그립감이 좋아서 손에 착 감기네요."
        };

        // 3. 1~32번 제품에 대해 랜덤 리뷰 생성
        for (int i = 1; i <= 32; i++) {
            String productId = String.valueOf(i);
            
            // ★ 수정됨: 제품당 1개 ~ 100개 사이 랜덤 생성
            int reviewCount = random.nextInt(100) + 1; 

            for (int j = 0; j < reviewCount; j++) {
                // 닉네임 조합
                String writer = nickAdj[random.nextInt(nickAdj.length)] + nickNoun[random.nextInt(nickNoun.length)];
                
                // 별점 확률 (5점 50%, 4점 30%, 3점 10%, 나머지 10%)
                int starProb = random.nextInt(100);
                int star = 5;
                if(starProb < 50) star = 5;
                else if(starProb < 80) star = 4;
                else if(starProb < 90) star = 3;
                else star = random.nextInt(2) + 1;
                
                // 내용 선택
                String content = contents[random.nextInt(contents.length)];
                
                // 날짜 생성 (최근 1년 이내 랜덤)
                LocalDate date = LocalDate.now().minusDays(random.nextInt(365));
                String dateStr = date.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));

                // 객체 생성
                Review newReview = new Review(productId, writer, "1234", content, star);
                
                // DTO에 setDate 메소드가 있어야 합니다.
                newReview.setDate(dateStr); 
                
                reviews.add(newReview);
            }
        }
    }
    // ★★★ 생성기 끝 ★★★

    // 전체 가져오기
    public static List<Review> getAllReviews() {
        return reviews;
    }

    // 특정 상품 리뷰 가져오기 (정렬 포함)
    public static List<Review> getSortedReviews(String productId, String sort) {
        List<Review> result = new ArrayList<>();
        for(Review r : reviews) {
            if(r.getProductId().equals(productId)) {
                result.add(r);
            }
        }
        
        // 정렬 로직
        if("latest".equals(sort)) {
            result.sort((r1, r2) -> r2.getDate().compareTo(r1.getDate()));
        } else if("oldest".equals(sort)) {
            result.sort((r1, r2) -> r1.getDate().compareTo(r2.getDate()));
        } else if("high".equals(sort)) {
            result.sort((r1, r2) -> Integer.compare(r2.getStar(), r1.getStar()));
        } else if("low".equals(sort)) {
            result.sort((r1, r2) -> Integer.compare(r1.getStar(), r2.getStar()));
        }
        
        return result;
    }

    public static Review getReviewByUid(String uid) {
        for(Review r : reviews) {
            if(r.getUid().equals(uid)) return r;
        }
        return null;
    }

    public static void addReview(Review r) {
        reviews.add(r);
    }

    public static void deleteReview(String uid) {
        for(int i=0; i<reviews.size(); i++) {
            if(reviews.get(i).getUid().equals(uid)) {
                reviews.remove(i);
                break;
            }
        }
    }

    public static void updateReview(String uid, int star, String content) {
        for(Review r : reviews) {
            if(r.getUid().equals(uid)) {
                r.setStar(star);
                r.setContent(content);
                break;
            }
        }
    }
    
    // 평균 평점
    public static double getAverageRating(String productId) {
        int sum = 0;
        int count = 0;
        for(Review r : reviews) {
            if(r.getProductId().equals(productId)) {
                sum += r.getStar();
                count++;
            }
        }
        return count == 0 ? 0.0 : (double)sum / count;
    }
    
    // 리뷰 개수
    public static int getReviewCount(String productId) {
        int count = 0;
        for(Review r : reviews) {
            if(r.getProductId().equals(productId)) {
                count++;
            }
        }
        return count;
    }
}