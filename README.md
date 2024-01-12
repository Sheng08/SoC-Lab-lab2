# [SoC Lab] Lab2
###### tags: `SoC Lab`, `SOC Design`

| Student ID | Name |
|------------|------|
| 311551095  | 林聖博|

###### 附上此篇Hackmd Link：[https://hackmd.io/@Sheng08/Hy8gkU2ep](https://hackmd.io/@Sheng08/Hy8gkU2ep)

- [\[SoC Lab\] Lab2](#soc-lab-lab2)
  - [Lab 2](#lab-2)
  - [Brief introduction about the overall system](#brief-introduction-about-the-overall-system)
  - [What is observed \& learned](#what-is-observed--learned)
    - [Differences between MAXI and Stream interface](#differences-between-maxi-and-stream-interface)
    - [Differences between csim and cosim](#differences-between-csim-and-cosim)
  - [Screen dump](#screen-dump)
    - [\[FIRN11MAXI\] FIR AXI-Master Interface](#firn11maxi-fir-axi-master-interface)
    - [\[FIRN11Stream\] FIR Stream Interface](#firn11stream-fir-stream-interface)
  - [Note](#memo-note)
    - [名詞解釋](#名詞解釋)
    - [觀念補充](#觀念補充)
  - [Troubleshooting](#troubleshooting)
  - [補充](#rocket-補充)


## Lab 2

* https://github.com/bol-edu/course-lab_2


## Brief introduction about the overall system
本次Lab2實驗中，主題為實作`FIR`並且使用兩種不同的Interface實作，分別為**AXI_Master**與**AXI_Stream**來傳輸測試資料。

設定這兩種Interface的方式也各有不同：
 - AXI_Master: 透過 `directive`(.tcl) 設定
 - AXI_Stream: 則使用 `pragma` (相似 Lab1) 設定

根據實驗結果，可以發現當需要*傳輸大量資料*時，
- **AXI_Master**在時間上(Latency)的表現較佳，其原因為**AXI_Stream**需依賴於額外的AXI_DMA資源協助且資料傳輸方式是基於FIFO，因此資料是逐一傳輸。
- **AXI_Master**則有Memory-mapping的特性，能直接地映射記憶體位址。

因此，如果需要以*隨機存取*的方式獲取測試資料，**AXI_Master是較佳的選擇**；而相對於*連續地存取*記憶體測試資料，則建議使用**AXI_Stream**。


## What is observed & learned
### Differences between MAXI and Stream interface
||MAXI|Stream|
|-|:----:|:------:|
|Latency of Kernel function|724 **fast**|6603|
|Execution time in online FPGA| 0.26ms(0.00026s) **fast**| 0.87ms (0.00087s)|
|Kernel func arguments|Pointer to an Array|hls:stream|
|Address Idea|Yes|No|
|Direction|Input/Output|Input / Output only|
|DMA|Not Need|Need|
|Stroage for test data|Create **Buffer**|Define **Stream**|


### Differences between csim and cosim
- **C Simulation**:
    - 目的: 驗證C/C++的算法邏輯正確性
    - 說明: 為初步的模擬階段，只涉及C/C\++程式，**不涉及任何硬體描述語言**。基本上，這階段確保C/C\++程式在未進行任何合成或硬體轉換的情況下運行正確性
    - `Test bench` 和 `Top function` 會一同編譯成同一個執行檔(executable file)

- **Co Simulation**:
    - 目的: 驗證合成後的HDL程式碼與C/C++原始碼的**行為**是否一致。
    - 說明: 在這階段，原始C/C++程式碼和其合成的HDL程式碼將**同時模擬**。這是確保合成後的HDL實現與原始演算邏輯在功能上保持一致
    - `Top function` 會在 Simulator 運行。而資料(test data)會於`Test bench` 和 Simulator 各自所執行的 process 之間傳輸

![](https://i.imgur.com/M8aV45B.png)


## Screen dump

### [FIRN11MAXI] FIR AXI-Master Interface
* Performance
    > C Synthesis
    > ![](https://i.imgur.com/QLlWymn.png)

    > Co-Simulation
    > ![](https://i.imgur.com/zee4soq.png)

    > `csynth.rpt`
    > ![](https://i.imgur.com/Bp1oAwo.png)

    > `fir_n11_maxi_csynth.rpt`
    > ![](https://i.imgur.com/BDfxyfz.png)

* Utilization
    ![](https://i.imgur.com/6UuLwhk.png)

* Interface
    > `csynth.rpt`
    > ![](https://i.imgur.com/ryi7JPp.png)

    > `fir_n11_maxi_csynth.rpt`
    > ![](https://i.imgur.com/KQj5qgh.png)

* Co-simulation transcript/waveform
    ![](https://i.imgur.com/ISyvpz2.png)

* Jupyter Notebook execution result
    ![](https://i.imgur.com/6z0pFJQ.png)

#### [FIRN11MAXI] Screen dump (Other)
* Block Design
    ![](https://i.imgur.com/LTTtrIF.png)

* Memory map
    ![](https://i.imgur.com/jb4zTHG.png)

* Power
    ![](https://i.imgur.com/MAsLT1u.png)

* Implement Design
    ![](https://i.imgur.com/lmfYvA8.png)


### [FIRN11Stream] FIR Stream Interface
* Performance
    > C Synthesis
    > ![](https://i.imgur.com/OslNejj.png)

    > Co-Simulation
    > ![](https://i.imgur.com/9mEK3fJ.png)

    > `csynth.rpt`
    > ![](https://i.imgur.com/WyOs2YT.png)

    > `fir_n11_strm_csynth.rpt`
    > ![](https://i.imgur.com/jfnZrlm.png)

* Utilization
    ![](https://i.imgur.com/jKwrY7P.png)

* Interface
    > `csynth.rpt`
    > ![](https://i.imgur.com/Thv9NYw.png)

    > `fir_n11_maxi_csynth.rpt`
    > ![](https://i.imgur.com/SsPGMxw.png)

* Co-simulation transcript/waveform
    ![](https://i.imgur.com/grDO8Y4.png)

* Jupyter Notebook execution result
    ![](https://i.imgur.com/byAhbTS.png)

#### [FIRN11Stream] Screen dump (Other)
* Block Design
    ![](https://i.imgur.com/ssd1SUw.png)

* Memory map
    ![](https://i.imgur.com/6yAtZ3q.png)

* Power
    ![](https://i.imgur.com/PVpJZMb.png)

* Implement Design
    ![](https://i.imgur.com/xkfNm2e.png)

---

## :memo: Note

### 名詞解釋
- `ap_ctrl_chain`: dataflow pipelining
    - 允許多個功能在硬體中同時進行，以實現高效率的資料流處理
- `ap_ctrl_hs`: 要做 Co-Simulation top module 的 block level protocol 必須是 "hand-shake"
    - 一種機制，由 host function 去 start kernel function
- `ap_ctrl_none`: kernel啟動為 "data-driven"
    - 不需要 host trigger，只要有 data buffer 就會自動開始

### 觀念補充
1. Co-Simulation 的 `depth` 是模擬器參數，需要被明確指定。選擇一個過小或不指定 depth 可能會導致模擬不正確。
    - 值得注意的是，`depth` 並不直接代表硬體的buffer，而是與模擬器的操作有關
    - `FIFO depth` 要足夠容納所有要測試的 data 量
    - ![](https://i.imgur.com/XQVROtj.png)
2. 選擇適當演算法，能減省 hardware resource

---

## Troubleshooting
* 實驗過程中，設定 `depth` 非600(設定128)，會在 Co-Simulation 時產生錯誤，如附圖所示:
    ![](https://i.imgur.com/EtcgYj2.png)

## :rocket: **補充**
後續更多資訊會補充於以下HackMD
* https://hackmd.io/@Sheng08/HkzeBuDyp

:::info
:pushpin: **TODO**
- [ ]

:::

<!--
frame? 如何聽過熟
axi master stream?
waveform看deadlock
deadlock原理
除法資源多
repicat線路？
不知道loop多少 難合成
看快影片
-->