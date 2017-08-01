package com.by.json;

/**
 * Created by dingjing on 2017/3/15.
 */
public class MemberExcelJson {
    private String memberId;
    private String score;
    private String memberIc;
    private String createdTime;

    public String getMemberId() {
        return memberId;
    }

    public void setMemberId(String memberId) {
        this.memberId = memberId;
    }

    public String getScore() {
        return score;
    }

    public void setScore(String score) {
        this.score = score;
    }

    public String getMemberIc() {
        if(this.memberIc==null){
            return "";
        }
        return memberIc;
    }

    public void setMemberIc(String memberIc) {
        this.memberIc = memberIc;
    }

    public String getCreatedTime() {
        return createdTime;
    }

    public void setCreatedTime(String createdTime) {
        this.createdTime = createdTime;
    }
}
