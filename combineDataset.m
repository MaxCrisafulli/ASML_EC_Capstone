function dataCombined = combineDataset(dataset1,dataset2)
    dataCombined = dataset1;
    dataCombined.ECeuvInternal1 = [dataset1.ECeuvInternal1;dataset2.ECeuvInternal1];
    dataCombined.ECeuvInternal2 = [dataset1.ECeuvInternal2;dataset2.ECeuvInternal2];
    dataCombined.ECeuvInternal4 = [dataset1.ECeuvInternal4;dataset2.ECeuvInternal4];
    dataCombined.ECeuvInternal5 = [dataset1.ECeuvInternal5;dataset2.ECeuvInternal5];
    dataCombined.ECeuvValue = [dataset1.ECeuvValue;dataset2.ECeuvValue];
    dataCombined.ECeuvExternal = [dataset1.ECeuvExternal;dataset2.ECeuvExternal];
    dataCombined.ECeuvTarget = [dataset1.ECeuvTarget;dataset2.ECeuvTarget];
    dataCombined.ECtFireActual = [dataset1.ECtFireActual;dataset2.ECtFireActual];
    dataCombined.ECmiscellaneousStatus = [dataset1.ECmiscellaneousStatus;dataset2.ECmiscellaneousStatus];
    dataCombined.ECeuvRawExternal = [dataset1.ECeuvRawExternal;dataset2.ECeuvRawExternal];
    dataCombined.Time = [dataset1.Time;dataset2.Time];
    dataCombined.ECcrossingInterval = [dataset1.ECcrossingInterval;dataset2.ECcrossingInterval];
end

