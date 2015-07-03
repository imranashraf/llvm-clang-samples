; ModuleID = 'test.c'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [31 x i8] c"Address of init array %d = %p\0A\00", align 1
@.str.1 = private unnamed_addr constant [34 x i8] c"Address of created array %d = %p\0A\00", align 1
@.str.2 = private unnamed_addr constant [10 x i8] c"sum : %d\0A\00", align 1
@.str.3 = private unnamed_addr constant [11 x i8] c"diff : %d\0A\00", align 1
@.str.4 = private unnamed_addr constant [23 x i8] c"Loop Allocation Test.\0A\00", align 1

; Function Attrs: nounwind uwtable
define void @initVecs(i32* %vec, i32 %nElem) #0 {
entry:
  %vec.addr = alloca i32*, align 8
  %nElem.addr = alloca i32, align 4
  %i = alloca i32, align 4
  store i32* %vec, i32** %vec.addr, align 8
  store i32 %nElem, i32* %nElem.addr, align 4
  store i32 0, i32* %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %1 = load i32, i32* %nElem.addr, align 4
  %cmp = icmp slt i32 %0, %1
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %2 = load i32, i32* %i, align 4
  %3 = load i32*, i32** %vec.addr, align 8
  %call = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([31 x i8], [31 x i8]* @.str, i32 0, i32 0), i32 %2, i32* %3)
  %4 = load i32, i32* %i, align 4
  %5 = load i32, i32* %i, align 4
  %idxprom = sext i32 %5 to i64
  %6 = load i32*, i32** %vec.addr, align 8
  %arrayidx = getelementptr inbounds i32, i32* %6, i64 %idxprom
  store i32 %4, i32* %arrayidx, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %7 = load i32, i32* %i, align 4
  %inc = add nsw i32 %7, 1
  store i32 %inc, i32* %i, align 4
  br label %for.cond

for.end:                                          ; preds = %for.cond
  ret void
}

declare i32 @printf(i8*, ...) #1

; Function Attrs: nounwind uwtable
define void @sumVecs(i32* %sum, i32* %a, i32* %b, i32 %nElem) #0 {
entry:
  %sum.addr = alloca i32*, align 8
  %a.addr = alloca i32*, align 8
  %b.addr = alloca i32*, align 8
  %nElem.addr = alloca i32, align 4
  %i = alloca i32, align 4
  store i32* %sum, i32** %sum.addr, align 8
  store i32* %a, i32** %a.addr, align 8
  store i32* %b, i32** %b.addr, align 8
  store i32 %nElem, i32* %nElem.addr, align 4
  store i32 0, i32* %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %1 = load i32, i32* %nElem.addr, align 4
  %cmp = icmp slt i32 %0, %1
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %2 = load i32, i32* %i, align 4
  %idxprom = sext i32 %2 to i64
  %3 = load i32*, i32** %a.addr, align 8
  %arrayidx = getelementptr inbounds i32, i32* %3, i64 %idxprom
  %4 = load i32, i32* %arrayidx, align 4
  %5 = load i32, i32* %i, align 4
  %idxprom1 = sext i32 %5 to i64
  %6 = load i32*, i32** %b.addr, align 8
  %arrayidx2 = getelementptr inbounds i32, i32* %6, i64 %idxprom1
  %7 = load i32, i32* %arrayidx2, align 4
  %add = add nsw i32 %4, %7
  %8 = load i32, i32* %i, align 4
  %idxprom3 = sext i32 %8 to i64
  %9 = load i32*, i32** %sum.addr, align 8
  %arrayidx4 = getelementptr inbounds i32, i32* %9, i64 %idxprom3
  store i32 %add, i32* %arrayidx4, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %10 = load i32, i32* %i, align 4
  %inc = add nsw i32 %10, 1
  store i32 %inc, i32* %i, align 4
  br label %for.cond

for.end:                                          ; preds = %for.cond
  ret void
}

; Function Attrs: nounwind uwtable
define void @diffVecs(i32* %sum, i32* %a, i32* %b, i32 %nElem) #0 {
entry:
  %sum.addr = alloca i32*, align 8
  %a.addr = alloca i32*, align 8
  %b.addr = alloca i32*, align 8
  %nElem.addr = alloca i32, align 4
  %i = alloca i32, align 4
  store i32* %sum, i32** %sum.addr, align 8
  store i32* %a, i32** %a.addr, align 8
  store i32* %b, i32** %b.addr, align 8
  store i32 %nElem, i32* %nElem.addr, align 4
  store i32 0, i32* %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %1 = load i32, i32* %nElem.addr, align 4
  %cmp = icmp slt i32 %0, %1
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %2 = load i32, i32* %i, align 4
  %idxprom = sext i32 %2 to i64
  %3 = load i32*, i32** %a.addr, align 8
  %arrayidx = getelementptr inbounds i32, i32* %3, i64 %idxprom
  %4 = load i32, i32* %arrayidx, align 4
  %5 = load i32, i32* %i, align 4
  %idxprom1 = sext i32 %5 to i64
  %6 = load i32*, i32** %b.addr, align 8
  %arrayidx2 = getelementptr inbounds i32, i32* %6, i64 %idxprom1
  %7 = load i32, i32* %arrayidx2, align 4
  %sub = sub nsw i32 %4, %7
  %8 = load i32, i32* %i, align 4
  %idxprom3 = sext i32 %8 to i64
  %9 = load i32*, i32** %sum.addr, align 8
  %arrayidx4 = getelementptr inbounds i32, i32* %9, i64 %idxprom3
  store i32 %sub, i32* %arrayidx4, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %10 = load i32, i32* %i, align 4
  %inc = add nsw i32 %10, 1
  store i32 %inc, i32* %i, align 4
  br label %for.cond

for.end:                                          ; preds = %for.cond
  ret void
}

; Function Attrs: nounwind uwtable
define void @process() #0 {
entry:
  %nElem = alloca i32, align 4
  %nBytes = alloca i32, align 4
  %Vecs = alloca [4 x i32*], align 16
  %i = alloca i32, align 4
  store i32 10, i32* %nElem, align 4
  %0 = load i32, i32* %nElem, align 4
  %conv = sext i32 %0 to i64
  %mul = mul i64 %conv, 4
  %conv1 = trunc i64 %mul to i32
  store i32 %conv1, i32* %nBytes, align 4
  store i32 0, i32* %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %1 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %1, 4
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %2 = load i32, i32* %nBytes, align 4
  %conv3 = sext i32 %2 to i64
  %call = call noalias i8* @malloc(i64 %conv3) #3
  %3 = bitcast i8* %call to i32*
  %4 = load i32, i32* %i, align 4
  %idxprom = sext i32 %4 to i64
  %arrayidx = getelementptr inbounds [4 x i32*], [4 x i32*]* %Vecs, i32 0, i64 %idxprom
  store i32* %3, i32** %arrayidx, align 8
  %5 = load i32, i32* %i, align 4
  %6 = load i32, i32* %i, align 4
  %idxprom4 = sext i32 %6 to i64
  %arrayidx5 = getelementptr inbounds [4 x i32*], [4 x i32*]* %Vecs, i32 0, i64 %idxprom4
  %7 = load i32*, i32** %arrayidx5, align 8
  %call6 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([34 x i8], [34 x i8]* @.str.1, i32 0, i32 0), i32 %5, i32* %7)
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %8 = load i32, i32* %i, align 4
  %inc = add nsw i32 %8, 1
  store i32 %inc, i32* %i, align 4
  br label %for.cond

for.end:                                          ; preds = %for.cond
  %arrayidx7 = getelementptr inbounds [4 x i32*], [4 x i32*]* %Vecs, i32 0, i64 0
  %9 = load i32*, i32** %arrayidx7, align 8
  %10 = load i32, i32* %nElem, align 4
  call void @initVecs(i32* %9, i32 %10)
  %arrayidx8 = getelementptr inbounds [4 x i32*], [4 x i32*]* %Vecs, i32 0, i64 1
  %11 = load i32*, i32** %arrayidx8, align 8
  %12 = load i32, i32* %nElem, align 4
  call void @initVecs(i32* %11, i32 %12)
  %arrayidx9 = getelementptr inbounds [4 x i32*], [4 x i32*]* %Vecs, i32 0, i64 2
  %13 = load i32*, i32** %arrayidx9, align 8
  %arrayidx10 = getelementptr inbounds [4 x i32*], [4 x i32*]* %Vecs, i32 0, i64 0
  %14 = load i32*, i32** %arrayidx10, align 8
  %arrayidx11 = getelementptr inbounds [4 x i32*], [4 x i32*]* %Vecs, i32 0, i64 1
  %15 = load i32*, i32** %arrayidx11, align 8
  %16 = load i32, i32* %nElem, align 4
  call void @sumVecs(i32* %13, i32* %14, i32* %15, i32 %16)
  %arrayidx12 = getelementptr inbounds [4 x i32*], [4 x i32*]* %Vecs, i32 0, i64 3
  %17 = load i32*, i32** %arrayidx12, align 8
  %arrayidx13 = getelementptr inbounds [4 x i32*], [4 x i32*]* %Vecs, i32 0, i64 0
  %18 = load i32*, i32** %arrayidx13, align 8
  %arrayidx14 = getelementptr inbounds [4 x i32*], [4 x i32*]* %Vecs, i32 0, i64 1
  %19 = load i32*, i32** %arrayidx14, align 8
  %20 = load i32, i32* %nElem, align 4
  call void @diffVecs(i32* %17, i32* %18, i32* %19, i32 %20)
  %arrayidx15 = getelementptr inbounds [4 x i32*], [4 x i32*]* %Vecs, i32 0, i64 2
  %21 = load i32*, i32** %arrayidx15, align 8
  %arrayidx16 = getelementptr inbounds i32, i32* %21, i64 0
  %22 = load i32, i32* %arrayidx16, align 4
  %call17 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.2, i32 0, i32 0), i32 %22)
  %arrayidx18 = getelementptr inbounds [4 x i32*], [4 x i32*]* %Vecs, i32 0, i64 3
  %23 = load i32*, i32** %arrayidx18, align 8
  %arrayidx19 = getelementptr inbounds i32, i32* %23, i64 0
  %24 = load i32, i32* %arrayidx19, align 4
  %call20 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.3, i32 0, i32 0), i32 %24)
  store i32 0, i32* %i, align 4
  br label %for.cond.21

for.cond.21:                                      ; preds = %for.inc.27, %for.end
  %25 = load i32, i32* %i, align 4
  %cmp22 = icmp slt i32 %25, 4
  br i1 %cmp22, label %for.body.24, label %for.end.29

for.body.24:                                      ; preds = %for.cond.21
  %26 = load i32, i32* %i, align 4
  %idxprom25 = sext i32 %26 to i64
  %arrayidx26 = getelementptr inbounds [4 x i32*], [4 x i32*]* %Vecs, i32 0, i64 %idxprom25
  %27 = load i32*, i32** %arrayidx26, align 8
  %28 = bitcast i32* %27 to i8*
  call void @free(i8* %28) #3
  br label %for.inc.27

for.inc.27:                                       ; preds = %for.body.24
  %29 = load i32, i32* %i, align 4
  %inc28 = add nsw i32 %29, 1
  store i32 %inc28, i32* %i, align 4
  br label %for.cond.21

for.end.29:                                       ; preds = %for.cond.21
  ret void
}

; Function Attrs: nounwind
declare noalias i8* @malloc(i64) #2

; Function Attrs: nounwind
declare void @free(i8*) #2

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
entry:
  %retval = alloca i32, align 4
  store i32 0, i32* %retval
  %call = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str.4, i32 0, i32 0))
  call void @process()
  ret i32 0
}

attributes #0 = { nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.7.0 (trunk 240624)"}
