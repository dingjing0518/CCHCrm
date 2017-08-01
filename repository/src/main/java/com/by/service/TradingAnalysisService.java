package com.by.service;

import java.util.List;

public interface TradingAnalysisService {
    List<Object[]> findByFloor(String startTime, String endTime);
    
    List<Object[]> findByFloorAndBrand(String startTime, String endTime, String floor);
    
    List<String> findByValidFloor();
}
