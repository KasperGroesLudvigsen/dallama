python3 train.py \
--model_name meta-llama/Llama-2-70b-hf \
--batch_size 2 \
--context_length 512 \
--precision bf16 \
--train_type qlora \
--use_gradient_checkpointing true \
--use_cpu_offload true \
--dataset alpaca \
--reentrant_checkpointing true