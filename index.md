--- 
title: "The Book of OHDSI Korea"
author: "OHDSI-Korea"
date: "2019-10-22"
classoption: 11pt      
geometry:
- paperheight=10in 
- paperwidth=7in
- margin=1in
- inner=1in
- outer=0.65in
- top=0.8in
- bottom=0.8in
mainfont: NanumBarunGothic
bibliography:
- book.bib
- packages.bib
description: A book about the Observational Health Data Sciences and Informatics (OHDSI). It described the OHDSI community, open standards and open source software.
documentclass: book
favicon: images/favicon.ico
github-repo: OHDSI-Korea/TheBookOfOhdsiKorea
link-citations: yes
cover-image: images/Cover/Cover.png
site: bookdown::bookdown_site
biblio-style: apalike
url: https://ohdsi-korea.github.io/TheBookOfOhdsiKorea/
---



# 서문 {-}

<img src="images/Cover/Cover.png" width="250" height="375" alt="Cover image" align="right" style="margin: 0 1em 0 1em" /> 이 책은 관찰 보건 데이터 과학 및 정보학 (Observational Health Data Sicence and Informatics : OHDSI) 공동작업에 대한 내용을 담고있다.  OHDSI 커뮤니티에 의해 작성된 이 책은 OHDSI 관련 모든 지식의 중앙저장소 역활을 담당하고자 쓰여졌으며 오픈소스 개발 도구들을 통해 커뮤니티에 의해 관리되는 생명력있는 문서로 계속 진화하고 있다. 또한  [ohdsi-korea.github.io/TheBookOfOhdsiKorea/](https://ohdsi-korea.github.io/TheBookOfOhdsiKorea/)에서 온라인으로 항상 최신 버전의 책을 무료로 받아 볼 수 있으며 실물로 구입을 원할 경우  [Amazon](https://www.amazon.com/OHDSI-Observational-Health-Sciences-Informatics/dp/1088855199) 등에서 구입이 가능하다.

## 이 책의 목표 {-}

이 책은 OHDSI 관련 모든 지식의 중앙저장소 역할을 담당하고자 쓰여졌으며 OHDSI 커뮤니티, OHDSI 데이타 기준과 OHDSI 도구들에 중점을 두었다. OHDSI의 초보자와 숙련자 모두를 위해 현실적으로 필요 이론과 사용방법에 대한 교육을 제공하는 실용적인 부분에 목표를 두고 있다.  이 책을 읽은 뒤 당신은 OHDSI란 무엇인가, 또한 그 여정에 어떻게 동참할 것인가에 관하여 이해하게 될 것이다. 또한 공통 데이터 모델(CDM)과 표준화된 용어들이 무엇인지, 이러한 것들이 관찰 보건 데이터베이스의 표준화에 어떻게 사용되는지 알게 될 것이다. 이 데이터에 대해 Clinical characterization,  Population-level estimation, Population-level prediction, 이 3가지 주요 이용 사례들을 배우게 될 것이다. 이 책을 통해 이 3가지 활동을 지원하는 OHDSI의 오픈 소스 도구와 사용법에 대해 익히게 될 것이다.  데이터 품질, 임상적 타당성, 소프트웨어 타당성, 방법의 타당성 등에 관한 chapter들에서 CDM 에서 생성된 근거들의 품질을 어떻게 확립했는지를 설명할  것이다. 마지막으로, 분산 연구망에서 이러한 연구들을 실행하기 위해 OHDSI 를 어떻게 사용하는지를 배우게 될 것이다.

## 이 책의 구성 {-}

이 책은 5개의 주요 섹션으로 정리되어있다: 

I) OHDSI 커뮤니티
II) 획일적 데이터 표현
III) 데이터 분석
IV) 근거 품질
V) OHDSI 연구

각각의 섹션은 다수의  chapter로 구성되어 있으며 각각의 chapter는 아래의 순서대로 해당 chapter에 맞게 구성되어 있다: 도입, 이론, 실행, 요약, 예제. 

## 기여자 {-}

각각의 chapter는 해당 chapter를 이끈 주요 작성자들을 표기하고 있다. 그러나 주요작성자 외에도 이 책을 완성하는데 기여를 한 많은 사람들이 있으며 아래의 기여자들에게 감사를 표한다:


------------------  -----------------  ---------------------
Hamed Abedtash      Mustafa Ascha      Mark Beno            
Clair Blacketer     David Blatt        Brian Christian      
Gino Cloft          Frank DeFalco      Sara Dempster        
Jon Duke            Sergio Eslava      Clark Evans          
Thomas Falconer     George Hripcsak    Vojtech Huser        
Mark Khayter        Greg Klebanov      Kristin Kostka       
Bob Lanese          Wanda Lattimore    Chun Li              
David Madigan       Sindhoosha Malay   Harry Menegay        
Akihiko Nishimura   Ellen Palmer       Nirav Patil          
Jose Posada         Nicole Pratt       Dani Prieto-Alhambra 
Christian Reich     Jenna Reps         Peter Rijnbeek       
Patrick Ryan        Craig Sachson      Izzy Saridakis       
Paola Saroufim      Martijn Schuemie   Sarah Seager         
Anthony Sena        Sunah Song         Matt Spotnitz        
Marc Suchard        Joel Swerdel       Devin Tian           
Don Torok           Kees van Bochove   Mui Van Zandt        
Erica Voss          Kristin Waite      Mike Warfe           
Jamie Weaver        James Wiggins      Andrew Williams      
Seng Chan You                                               
------------------  -----------------  ---------------------

## 소프트웨어 버전 {-}

이 책의 많은 부분은 OHDSI의 오픈소스 소프트웨어를 다루고 있으며 이 소프트웨어는 시간이 지나면서 계속 진화해 나갈 것이다.  개발자들은 사용들에게 일관되고 안정적인 경험을 제공하고자 최선을 다할 것이나, 시간이 지나면서 소프트웨어의 개선으로 인해 불가피하게 이 책의 내용이 더이상 맞지 않는 경우가 발생할 것이다. 이를 보완하기 위해 커뮤니티는 온라인 버전을 통해 변화를 계속 업데이트할 예정이며 새로운 에디션의 실물 책을 출간할 예정이다. 
이 책이 쓰여진 버전의 소프트웨어 버전은 아래를 참고하면 된다 :

- ACHILLES: version 1.6.6
- ATLAS: version 2.7.3
- EUNOMIA: version 1.0.0
- Methods Library packages: 테이블 참조 \@ref(tab:packageVersions)


Table: (\#tab:packageVersions)Versions of packages in the Methods Library used in this book.

Package                    Version 
-------------------------  --------
CaseControl                1.6.0   
CaseCrossover              1.1.0   
CohortMethod               3.1.0   
Cyclops                    2.0.2   
DatabaseConnector          2.4.1   
EmpiricalCalibration       2.0.0   
EvidenceSynthesis          0.0.4   
FeatureExtraction          2.2.4   
MethodEvaluation           1.1.0   
ParallelLogger             1.1.0   
PatientLevelPrediction     3.0.6   
SelfControlledCaseSeries   1.4.0   
SelfControlledCohort       1.5.0   
SqlRender                  1.6.2   

## 라이선스 {-}

이 책은 [Creative Commons Zero v1.0 Universal license](http://creativecommons.org/publicdomain/zero/1.0/).로 인가되었다. 

![](images/Preface/cc0.png)

## 이 책이 쓰여진 과정 {-}

이 책은 [bookdown](https://bookdown.org) 패키지를 사용한 [RMarkdown](https://rmarkdown.rstudio.com)으로 쓰여졌다. 온라인 버전은 지속적 통합 시스템인 ["travis"](http://travis-ci.org/)를 통해서 [https://github.com/OHDSI-Korea/TheBookOfOhdsiKorea](https://github.com/OHDSI-Korea/TheBookOfOhdsiKorea)의 저장소를 사용해 자동작성 되었다. 이러한 온라인 버전은 정기적으로 스냅샷 형식으로 저장되며 이렇게 저장된 파일을 “에디션”이라 표기한다. 이 에디션들의 실물 책자들은 아마존에서 구입이 가능하다.
