ů
ůÎ
.
Abs
x"T
y"T"
Ttype:

2	
:
Add
x"T
y"T
z"T"
Ttype:
2	
x
Assign
ref"T

value"T

output_ref"T"	
Ttype"
validate_shapebool("
use_lockingbool(
k
BatchMatMulV2
x"T
y"T
output"T"
Ttype:

2	"
adj_xbool( "
adj_ybool( 
~
BiasAdd

value"T	
bias"T
output"T" 
Ttype:
2	"-
data_formatstringNHWC:
NHWCNCHW
Z
BroadcastTo

input"T
shape"Tidx
output"T"	
Ttype"
Tidxtype0:
2	
N
Cast	
x"SrcT	
y"DstT"
SrcTtype"
DstTtype"
Truncatebool( 
h
ConcatV2
values"T*N
axis"Tidx
output"T"
Nint(0"	
Ttype"
Tidxtype0:
2	
8
Const
output"dtype"
valuetensor"
dtypetype
W

ExpandDims

input"T
dim"Tdim
output"T"	
Ttype"
Tdimtype0:
2	
­
GatherV2
params"Tparams
indices"Tindices
axis"Taxis
output"Tparams"

batch_dimsint "
Tparamstype"
Tindicestype:
2	"
Taxistype:
2	
.
Identity

input"T
output"T"	
Ttype
q
MatMul
a"T
b"T
product"T"
transpose_abool( "
transpose_bbool( "
Ttype:

2	
6
MatrixDiagPart

input"T
diagonal"T"	
Ttype
e
MergeV2Checkpoints
checkpoint_prefixes
destination_prefix"
delete_old_dirsbool(
=
Mul
x"T
y"T
z"T"
Ttype:
2	

NoOp
M
Pack
values"T*N
output"T"
Nint(0"	
Ttype"
axisint 
C
Placeholder
output"dtype"
dtypetype"
shapeshape:
X
PlaceholderWithDefault
input"dtype
output"dtype"
dtypetype"
shapeshape

Prod

input"T
reduction_indices"Tidx
output"T"
	keep_dimsbool( " 
Ttype:
2	"
Tidxtype0:
2	
~
RandomUniform

shape"T
output"dtype"
seedint "
seed2int "
dtypetype:
2"
Ttype:
2	
[
Reshape
tensor"T
shape"Tshape
output"T"	
Ttype"
Tshapetype0:
2	
o
	RestoreV2

prefix
tensor_names
shape_and_slices
tensors2dtypes"
dtypes
list(type)(0
l
SaveV2

prefix
tensor_names
shape_and_slices
tensors2dtypes"
dtypes
list(type)(0
P
Shape

input"T
output"out_type"	
Ttype"
out_typetype0:
2	
H
ShardedFilename
basename	
shard

num_shards
filename
0
Sigmoid
x"T
y"T"
Ttype:

2
9
Softmax
logits"T
softmax"T"
Ttype:
2
N

StringJoin
inputs*N

output"
Nint(0"
	separatorstring 
:
Sub
x"T
y"T
z"T"
Ttype:
2	
P
	Transpose
x"T
perm"Tperm
y"T"	
Ttype"
Tpermtype0:
2	

TruncatedNormal

shape"T
output"dtype"
seedint "
seed2int "
dtypetype:
2"
Ttype:
2	
s

VariableV2
ref"dtype"
shapeshape"
dtypetype"
	containerstring "
shared_namestring "serve*1.15.02v1.15.0-0-g590d6eef7e8p

global_step/Initializer/zerosConst*
value	B	 R *
_class
loc:@global_step*
dtype0	*
_output_shapes
: 
k
global_step
VariableV2*
dtype0	*
_output_shapes
: *
shape: *
_class
loc:@global_step

global_step/AssignAssignglobal_stepglobal_step/Initializer/zeros*
T0	*
_class
loc:@global_step*
_output_shapes
: 
j
global_step/readIdentityglobal_step*
_output_shapes
: *
T0	*
_class
loc:@global_step


embeddingsPlaceholder*
dtype0*5
_output_shapes#
!:˙˙˙˙˙˙˙˙˙˙˙˙˙˙˙˙˙˙**
shape!:˙˙˙˙˙˙˙˙˙˙˙˙˙˙˙˙˙˙


input_maskPlaceholder*
dtype0*0
_output_shapes
:˙˙˙˙˙˙˙˙˙˙˙˙˙˙˙˙˙˙*%
shape:˙˙˙˙˙˙˙˙˙˙˙˙˙˙˙˙˙˙
Ľ
/shared_query/Initializer/truncated_normal/shapeConst*
dtype0*
_output_shapes
:*!
valueB"          *
_class
loc:@shared_query

.shared_query/Initializer/truncated_normal/meanConst*
valueB
 *    *
_class
loc:@shared_query*
dtype0*
_output_shapes
: 

0shared_query/Initializer/truncated_normal/stddevConst*
valueB
 *
×Ł<*
_class
loc:@shared_query*
dtype0*
_output_shapes
: 
Ö
9shared_query/Initializer/truncated_normal/TruncatedNormalTruncatedNormal/shared_query/Initializer/truncated_normal/shape*
T0*
_class
loc:@shared_query*
dtype0* 
_output_shapes
:
 
í
-shared_query/Initializer/truncated_normal/mulMul9shared_query/Initializer/truncated_normal/TruncatedNormal0shared_query/Initializer/truncated_normal/stddev*
_class
loc:@shared_query* 
_output_shapes
:
 *
T0
Ű
)shared_query/Initializer/truncated_normalAdd-shared_query/Initializer/truncated_normal/mul.shared_query/Initializer/truncated_normal/mean*
T0*
_class
loc:@shared_query* 
_output_shapes
:
 

shared_query
VariableV2*
dtype0* 
_output_shapes
:
 *
shape:
 *
_class
loc:@shared_query
˘
shared_query/AssignAssignshared_query)shared_query/Initializer/truncated_normal* 
_output_shapes
:
 *
T0*
_class
loc:@shared_query
w
shared_query/readIdentityshared_query*
T0*
_class
loc:@shared_query* 
_output_shapes
:
 
f
BroadcastTo/shapeConst*!
valueB"          *
dtype0*
_output_shapes
:
k
BroadcastToBroadcastToshared_query/readBroadcastTo/shape* 
_output_shapes
:
 *
T0
Ł
.class_query/Initializer/truncated_normal/shapeConst*!
valueB"         *
_class
loc:@class_query*
dtype0*
_output_shapes
:

-class_query/Initializer/truncated_normal/meanConst*
valueB
 *    *
_class
loc:@class_query*
dtype0*
_output_shapes
: 

/class_query/Initializer/truncated_normal/stddevConst*
valueB
 *
×Ł<*
_class
loc:@class_query*
dtype0*
_output_shapes
: 
Ö
8class_query/Initializer/truncated_normal/TruncatedNormalTruncatedNormal.class_query/Initializer/truncated_normal/shape*
T0*
_class
loc:@class_query*
dtype0*#
_output_shapes
:
ě
,class_query/Initializer/truncated_normal/mulMul8class_query/Initializer/truncated_normal/TruncatedNormal/class_query/Initializer/truncated_normal/stddev*#
_output_shapes
:*
T0*
_class
loc:@class_query
Ú
(class_query/Initializer/truncated_normalAdd,class_query/Initializer/truncated_normal/mul-class_query/Initializer/truncated_normal/mean*#
_output_shapes
:*
T0*
_class
loc:@class_query

class_query
VariableV2*
_class
loc:@class_query*
dtype0*#
_output_shapes
:*
shape:
Ą
class_query/AssignAssignclass_query(class_query/Initializer/truncated_normal*
T0*
_class
loc:@class_query*#
_output_shapes
:
w
class_query/readIdentityclass_query*
T0*
_class
loc:@class_query*#
_output_shapes
:
M
concat/axisConst*
value	B :*
dtype0*
_output_shapes
: 
u
concatConcatV2BroadcastToclass_query/readconcat/axis*
T0*
N*#
_output_shapes
:
w
MatMulBatchMatMulV2concat
embeddings*
adj_y(*
T0*4
_output_shapes"
 :˙˙˙˙˙˙˙˙˙˙˙˙˙˙˙˙˙˙
G
sub/yConst*
value	B :*
dtype0*
_output_shapes
: 
X
subSub
input_masksub/y*0
_output_shapes
:˙˙˙˙˙˙˙˙˙˙˙˙˙˙˙˙˙˙*
T0
J
AbsAbssub*
T0*0
_output_shapes
:˙˙˙˙˙˙˙˙˙˙˙˙˙˙˙˙˙˙
[
CastCastAbs*

SrcT0*0
_output_shapes
:˙˙˙˙˙˙˙˙˙˙˙˙˙˙˙˙˙˙*

DstT0
P
ExpandDims/dimConst*
_output_shapes
: *
value	B :*
dtype0
m

ExpandDims
ExpandDimsCastExpandDims/dim*4
_output_shapes"
 :˙˙˙˙˙˙˙˙˙˙˙˙˙˙˙˙˙˙*
T0
J
mul/xConst*
valueB
 *(knN*
dtype0*
_output_shapes
: 
\
mulMulmul/x
ExpandDims*
T0*4
_output_shapes"
 :˙˙˙˙˙˙˙˙˙˙˙˙˙˙˙˙˙˙
X
sub_1SubMatMulmul*4
_output_shapes"
 :˙˙˙˙˙˙˙˙˙˙˙˙˙˙˙˙˙˙*
T0
X
SoftmaxSoftmaxsub_1*
T0*4
_output_shapes"
 :˙˙˙˙˙˙˙˙˙˙˙˙˙˙˙˙˙˙
e
MatMul_1BatchMatMulV2Softmax
embeddings*
T0*,
_output_shapes
:˙˙˙˙˙˙˙˙˙

-dense/kernel/Initializer/random_uniform/shapeConst*
valueB"      *
_class
loc:@dense/kernel*
dtype0*
_output_shapes
:

+dense/kernel/Initializer/random_uniform/minConst*
valueB
 *˝´˝*
_class
loc:@dense/kernel*
dtype0*
_output_shapes
: 

+dense/kernel/Initializer/random_uniform/maxConst*
valueB
 *˝´=*
_class
loc:@dense/kernel*
dtype0*
_output_shapes
: 
Í
5dense/kernel/Initializer/random_uniform/RandomUniformRandomUniform-dense/kernel/Initializer/random_uniform/shape*
_output_shapes
:	*
T0*
_class
loc:@dense/kernel*
dtype0
Î
+dense/kernel/Initializer/random_uniform/subSub+dense/kernel/Initializer/random_uniform/max+dense/kernel/Initializer/random_uniform/min*
T0*
_class
loc:@dense/kernel*
_output_shapes
: 
á
+dense/kernel/Initializer/random_uniform/mulMul5dense/kernel/Initializer/random_uniform/RandomUniform+dense/kernel/Initializer/random_uniform/sub*
_class
loc:@dense/kernel*
_output_shapes
:	*
T0
Ó
'dense/kernel/Initializer/random_uniformAdd+dense/kernel/Initializer/random_uniform/mul+dense/kernel/Initializer/random_uniform/min*
T0*
_class
loc:@dense/kernel*
_output_shapes
:	

dense/kernel
VariableV2*
dtype0*
_output_shapes
:	*
shape:	*
_class
loc:@dense/kernel

dense/kernel/AssignAssigndense/kernel'dense/kernel/Initializer/random_uniform*
T0*
_class
loc:@dense/kernel*
_output_shapes
:	
v
dense/kernel/readIdentitydense/kernel*
_output_shapes
:	*
T0*
_class
loc:@dense/kernel

dense/bias/Initializer/zerosConst*
valueB*    *
_class
loc:@dense/bias*
dtype0*
_output_shapes
:
q

dense/bias
VariableV2*
_class
loc:@dense/bias*
dtype0*
_output_shapes
:*
shape:

dense/bias/AssignAssign
dense/biasdense/bias/Initializer/zeros*
T0*
_class
loc:@dense/bias*
_output_shapes
:
k
dense/bias/readIdentity
dense/bias*
_output_shapes
:*
T0*
_class
loc:@dense/bias
^
dense/Tensordot/axesConst*
valueB:*
dtype0*
_output_shapes
:
e
dense/Tensordot/freeConst*
valueB"       *
dtype0*
_output_shapes
:
M
dense/Tensordot/ShapeShapeMatMul_1*
_output_shapes
:*
T0
_
dense/Tensordot/GatherV2/axisConst*
value	B : *
dtype0*
_output_shapes
: 
¸
dense/Tensordot/GatherV2GatherV2dense/Tensordot/Shapedense/Tensordot/freedense/Tensordot/GatherV2/axis*
_output_shapes
:*
Taxis0*
Tindices0*
Tparams0
a
dense/Tensordot/GatherV2_1/axisConst*
value	B : *
dtype0*
_output_shapes
: 
ź
dense/Tensordot/GatherV2_1GatherV2dense/Tensordot/Shapedense/Tensordot/axesdense/Tensordot/GatherV2_1/axis*
_output_shapes
:*
Taxis0*
Tindices0*
Tparams0
_
dense/Tensordot/ConstConst*
valueB: *
dtype0*
_output_shapes
:
n
dense/Tensordot/ProdProddense/Tensordot/GatherV2dense/Tensordot/Const*
T0*
_output_shapes
: 
a
dense/Tensordot/Const_1Const*
valueB: *
dtype0*
_output_shapes
:
t
dense/Tensordot/Prod_1Proddense/Tensordot/GatherV2_1dense/Tensordot/Const_1*
_output_shapes
: *
T0
]
dense/Tensordot/concat/axisConst*
value	B : *
dtype0*
_output_shapes
: 

dense/Tensordot/concatConcatV2dense/Tensordot/freedense/Tensordot/axesdense/Tensordot/concat/axis*
T0*
N*
_output_shapes
:
y
dense/Tensordot/stackPackdense/Tensordot/Proddense/Tensordot/Prod_1*
T0*
N*
_output_shapes
:

dense/Tensordot/transpose	TransposeMatMul_1dense/Tensordot/concat*
T0*,
_output_shapes
:˙˙˙˙˙˙˙˙˙

dense/Tensordot/ReshapeReshapedense/Tensordot/transposedense/Tensordot/stack*
T0*0
_output_shapes
:˙˙˙˙˙˙˙˙˙˙˙˙˙˙˙˙˙˙
q
 dense/Tensordot/transpose_1/permConst*
valueB"       *
dtype0*
_output_shapes
:

dense/Tensordot/transpose_1	Transposedense/kernel/read dense/Tensordot/transpose_1/perm*
T0*
_output_shapes
:	
p
dense/Tensordot/Reshape_1/shapeConst*
_output_shapes
:*
valueB"      *
dtype0

dense/Tensordot/Reshape_1Reshapedense/Tensordot/transpose_1dense/Tensordot/Reshape_1/shape*
T0*
_output_shapes
:	

dense/Tensordot/MatMulMatMuldense/Tensordot/Reshapedense/Tensordot/Reshape_1*'
_output_shapes
:˙˙˙˙˙˙˙˙˙*
T0
a
dense/Tensordot/Const_2Const*
valueB:*
dtype0*
_output_shapes
:
_
dense/Tensordot/concat_1/axisConst*
_output_shapes
: *
value	B : *
dtype0
¤
dense/Tensordot/concat_1ConcatV2dense/Tensordot/GatherV2dense/Tensordot/Const_2dense/Tensordot/concat_1/axis*
_output_shapes
:*
T0*
N

dense/TensordotReshapedense/Tensordot/MatMuldense/Tensordot/concat_1*
T0*+
_output_shapes
:˙˙˙˙˙˙˙˙˙
p
dense/BiasAddBiasAdddense/Tensordotdense/bias/read*
T0*+
_output_shapes
:˙˙˙˙˙˙˙˙˙
\
	diag_partMatrixDiagPartdense/BiasAdd*'
_output_shapes
:˙˙˙˙˙˙˙˙˙*
T0
O
SigmoidSigmoid	diag_part*
T0*'
_output_shapes
:˙˙˙˙˙˙˙˙˙

initNoOp

init_all_tablesNoOp

init_1NoOp
4

group_depsNoOp^init^init_1^init_all_tables
Y
save/filename/inputConst*
valueB Bmodel*
dtype0*
_output_shapes
: 
n
save/filenamePlaceholderWithDefaultsave/filename/input*
_output_shapes
: *
shape: *
dtype0
e

save/ConstPlaceholderWithDefaultsave/filename*
dtype0*
_output_shapes
: *
shape: 

save/StringJoin/inputs_1Const*<
value3B1 B+_temp_76af55e4f39841019b0a9363c69a2462/part*
dtype0*
_output_shapes
: 
d
save/StringJoin
StringJoin
save/Constsave/StringJoin/inputs_1*
N*
_output_shapes
: 
Q
save/num_shardsConst*
value	B :*
dtype0*
_output_shapes
: 
k
save/ShardedFilename/shardConst"/device:CPU:0*
value	B : *
dtype0*
_output_shapes
: 

save/ShardedFilenameShardedFilenamesave/StringJoinsave/ShardedFilename/shardsave/num_shards"/device:CPU:0*
_output_shapes
: 
°
save/SaveV2/tensor_namesConst"/device:CPU:0*U
valueLBJBclass_queryB
dense/biasBdense/kernelBglobal_stepBshared_query*
dtype0*
_output_shapes
:
|
save/SaveV2/shape_and_slicesConst"/device:CPU:0*
valueBB B B B B *
dtype0*
_output_shapes
:
É
save/SaveV2SaveV2save/ShardedFilenamesave/SaveV2/tensor_namessave/SaveV2/shape_and_slicesclass_query
dense/biasdense/kernelglobal_stepshared_query"/device:CPU:0*
dtypes	
2	
 
save/control_dependencyIdentitysave/ShardedFilename^save/SaveV2"/device:CPU:0*
T0*'
_class
loc:@save/ShardedFilename*
_output_shapes
: 
 
+save/MergeV2Checkpoints/checkpoint_prefixesPacksave/ShardedFilename^save/control_dependency"/device:CPU:0*
T0*
N*
_output_shapes
:
u
save/MergeV2CheckpointsMergeV2Checkpoints+save/MergeV2Checkpoints/checkpoint_prefixes
save/Const"/device:CPU:0

save/IdentityIdentity
save/Const^save/MergeV2Checkpoints^save/control_dependency"/device:CPU:0*
T0*
_output_shapes
: 
ł
save/RestoreV2/tensor_namesConst"/device:CPU:0*U
valueLBJBclass_queryB
dense/biasBdense/kernelBglobal_stepBshared_query*
dtype0*
_output_shapes
:

save/RestoreV2/shape_and_slicesConst"/device:CPU:0*
dtype0*
_output_shapes
:*
valueBB B B B B 
ł
save/RestoreV2	RestoreV2
save/Constsave/RestoreV2/tensor_namessave/RestoreV2/shape_and_slices"/device:CPU:0*(
_output_shapes
:::::*
dtypes	
2	

save/AssignAssignclass_querysave/RestoreV2*
_class
loc:@class_query*#
_output_shapes
:*
T0
y
save/Assign_1Assign
dense/biassave/RestoreV2:1*
T0*
_class
loc:@dense/bias*
_output_shapes
:

save/Assign_2Assigndense/kernelsave/RestoreV2:2*
T0*
_class
loc:@dense/kernel*
_output_shapes
:	
w
save/Assign_3Assignglobal_stepsave/RestoreV2:3*
T0	*
_class
loc:@global_step*
_output_shapes
: 

save/Assign_4Assignshared_querysave/RestoreV2:4*
T0*
_class
loc:@shared_query* 
_output_shapes
:
 
h
save/restore_shardNoOp^save/Assign^save/Assign_1^save/Assign_2^save/Assign_3^save/Assign_4
-
save/restore_allNoOp^save/restore_shard"<
save/Const:0save/Identity:0save/restore_all (5 @F8"m
global_step^\
Z
global_step:0global_step/Assignglobal_step/read:02global_step/Initializer/zeros:0H"
	variablesňď
Z
global_step:0global_step/Assignglobal_step/read:02global_step/Initializer/zeros:0H
i
shared_query:0shared_query/Assignshared_query/read:02+shared_query/Initializer/truncated_normal:08
e
class_query:0class_query/Assignclass_query/read:02*class_query/Initializer/truncated_normal:08
g
dense/kernel:0dense/kernel/Assigndense/kernel/read:02)dense/kernel/Initializer/random_uniform:08
V
dense/bias:0dense/bias/Assigndense/bias/read:02dense/bias/Initializer/zeros:08"%
saved_model_main_op


group_deps"Ž
trainable_variables
i
shared_query:0shared_query/Assignshared_query/read:02+shared_query/Initializer/truncated_normal:08
e
class_query:0class_query/Assignclass_query/read:02*class_query/Initializer/truncated_normal:08
g
dense/kernel:0dense/kernel/Assigndense/kernel/read:02)dense/kernel/Initializer/random_uniform:08
V
dense/bias:0dense/bias/Assigndense/bias/read:02dense/bias/Initializer/zeros:08*Ő
serving_defaultÁ
?

embeddings1
embeddings:0˙˙˙˙˙˙˙˙˙˙˙˙˙˙˙˙˙˙
:

input_mask,
input_mask:0˙˙˙˙˙˙˙˙˙˙˙˙˙˙˙˙˙˙1
probabilities 
	Sigmoid:0˙˙˙˙˙˙˙˙˙:
	attention-
	Softmax:0˙˙˙˙˙˙˙˙˙˙˙˙˙˙˙˙˙˙7
pooled_output&

MatMul_1:0˙˙˙˙˙˙˙˙˙tensorflow/serving/predict